# frozen_string_literal: true

module Mutations
  class UpdateQuestion < BaseMutation
    graphql_name 'Update Question'
    description 'Update Question'

    # arguments passed to the `resolved` method
    argument :id, ID, required: true
    argument :question_type, String, required: false
    argument :standard_id, ID, required: false
    argument :tags, [String], required: false
    argument :rich_text, String, required: false
    argument :question_plaintext, String, required: false
    argument :question_options, [String], required: false

    # return type from the mutation
    type Types::QuestionType

  def process_images!(rich_text)
    rich = JSON.parse(rich_text)
    nodes = rich['document']['nodes'].map do |node|
      node['data']['file'] = upload_to_s3(node) if node['type'] == 'image'
      node
    end
    rich['document']['nodes'] = nodes
    rich.to_json
  end

    def resolve(
      id:,
      question_type: nil,
      rich_text: nil,
      question_plaintext: nil,
      standard_id: nil,
      tags: [],
      question_options: []
      )
      question = Question.find(id)
      question.question_type = question_type if question_type
      question.question_text = question_plaintext if question_plaintext
      question.rich_text = process_images!(rich_text) if rich_text

      # update standards and tags associations
      question.standards = [Standard.find(standard_id)] if standard_id
      question.tags = tags.map{ |tag| Tag.find_or_create_by(name: tag) } if tags

      # destrory answer choices that are deleted
      # ex: [4, 5] - [5] = [4]
      oldQuestionOptionsIds = question.question_options.pluck(:id);
      responseQuestionOptionsIds = question_options.map { |option| JSON.parse(option)["id"].to_i };
      deletedQuestionIds = oldQuestionOptionsIds - responseQuestionOptionsIds
      deletedQuestionIds.each { |optionId| QuestionOption.destroy(optionId) }

      # update answer choices
      num_answer_choices = question_options.length
      question_options.each do |option|
        option_obj = JSON.parse(option)
        rich_text = process_images!(option_obj['richText'].to_json)
        option_obj_id = option_obj["id"]

        if (option_obj_id)
          question_option = QuestionOption.find(option_obj_id)
          question_option.update_attributes({
            correct: option_obj['correct'],
            rich_text: rich_text,
            option_text: option_obj['optionText']
          })
        else
          question.question_options.create({
            correct: num_answer_choices == 1 || option_obj['correct'],
            rich_text: rich_text,
            option_text: option_obj['optionText']
          })
        end
      end

      question.save!
      # todo:to_json => extract id, update plain text and rich text
      question
    end
  end
end
