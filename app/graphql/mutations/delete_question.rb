# frozen_string_literal: true

module Mutations
  class DeleteQuestion < BaseMutation
    graphql_name 'Delete Question'
    description 'Delete Question'

    # arguments passed to the `resolved` method
    argument :question_id, ID, required: true

    # return type from the mutation
    type Types::QuestionType

    def resolve(question_id:)
      question = current_teacher.questions.find(question_id)
      question.destroy

      question
    end
  end
end
