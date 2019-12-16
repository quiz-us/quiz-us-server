# frozen_string_literal: true

module Mutations
  class UpdateQuestion < BaseMutation
    include ImageS3Processable

    graphql_name 'Update Question'
    description 'Update Question'

    # arguments passed to the `resolved` method
    argument :id, ID, required: true
    argument :standard_id, ID, required: false
    argument :tags, [String], required: false
    argument :rich_text, String, required: false
    argument :question_plaintext, String, required: false
    argument :question_options, [String], required: false

    # return type from the mutation
    type Types::QuestionType

    def resolve(
      id:,
      rich_text: nil,
      question_plaintext: nil,
      standard_id: nil,
      tags: [],
      question_options: []
    )
      @question = Question.find(id)
      @question.question_text = question_plaintext
      @question.rich_text = process_images!(rich_text)

      # update standards and tags associations
      @question.standards = [Standard.find(standard_id)] 
      @question.tags = tags.map { |tag| Tag.find_or_create_by(name: tag) }
      @question_options = question_options

      orphan_old_answer_choices
      update_answer_choices
      @question.save! #do we even need this?
      @question
    end

    private

    def orphan_old_answer_choices
      # ex: [4, 5] - [5] = [4]
      oldQuestionOptionsIds = @question.question_options.pluck(:id)
      updatedQuestionOptionsIds = @question_options.map { |option| JSON.parse(option)['id'].to_i }
      deletedQuestionIds = oldQuestionOptionsIds - updatedQuestionOptionsIds

      deletedQuestionIds.each { |option_id| QuestionOption.find(option_id).update!(question_id: nil) }
    end

    def update_answer_choices
      num_answer_choices = @question_options.length
      @question_options.each do |option|
        option_obj = JSON.parse(option)
        rich_text = process_images!(option_obj['richText'].to_json)
        option_obj_id = option_obj['id']

        if option_obj_id
          question_option = QuestionOption.find(option_obj_id)
          question_option.update(
            correct: option_obj['correct'],
            rich_text: rich_text,
            option_text: option_obj['optionText']
          )
        else
          @question.question_options.create(
            correct: num_answer_choices == 1 || option_obj['correct'],
            rich_text: rich_text,
            option_text: option_obj['optionText']
          )
        end
      end
    end
  end
end
