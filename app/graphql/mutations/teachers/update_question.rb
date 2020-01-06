# frozen_string_literal: true

module Mutations
  module Teachers
    class UpdateQuestion < TeacherMutation
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
        question = Question.find(id)
        question.question_text = question_plaintext if question_plaintext
        question.rich_text = process_images!(rich_text) if rich_text

        # update standards and tags associations
        question.standards = [Standard.find(standard_id)] if standard_id
        question.tags = tags.map { |tag| Tag.find_or_create_by(name: tag) }

        orphan_old_answer_choices!(question, question_options)
        update_answer_choices!(question, question_options)
        # call save to persist the changes:
        question.save!
        question
      end

      private

      def orphan_old_answer_choices!(question, question_options)
        # ex: [4, 5] - [5] = [4]
        old_question_options_ids = question.question_options.pluck(:id)

        updated_question_options_ids = question_options.map do |option|
          JSON.parse(option)['id'].to_i
        end
        deleted_question_ids = old_question_options_ids - updated_question_options_ids

        deleted_question_ids.each do |option_id|
          QuestionOption.find(option_id).update!(question_id: nil)
        end
      end

      def update_answer_choices!(question, question_options)
        num_answer_choices = question_options.length
        question_options.each do |option|
          option_obj = JSON.parse(option)
          rich_text = process_images!(option_obj['richText'])
          option_obj_id = option_obj['id']

          if option_obj_id
            question_option = QuestionOption.find(option_obj_id)
            question_option.update(
              correct: option_obj['correct'],
              rich_text: rich_text,
              option_text: option_obj['optionText']
            )
          else
            question.question_options.create(
              correct: num_answer_choices == 1 || option_obj['correct'],
              rich_text: rich_text,
              option_text: option_obj['optionText']
            )
          end
        end
      end
    end
  end
end
