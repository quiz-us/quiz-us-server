# frozen_string_literal: true

module Mutations
  module Teachers
    class CreateQuestion < TeacherMutation
      graphql_name 'Create Question'
      description 'Create Question'

      # arguments passed to the `resolved` method
      argument :question_type, String, required: true
      argument :standard_id, ID, required: false
      argument :tags, [String], required: false
      argument :rich_text, String, required: true
      argument :question_plaintext, String, required: true
      argument :question_options, [String], required: false

      # return type from the mutation
      type Types::QuestionType

      def resolve(rich_text:, question_type:, tags:, standard_id:, question_plaintext:, question_options:)
        CreateQuestionService.call(
          rich_text: rich_text,
          question_type: question_type,
          tags: tags,
          standard_id: standard_id,
          question_plaintext: question_plaintext,
          question_options: question_options,
          teacher_id: current_teacher.id
        )
      end
    end
  end
end
