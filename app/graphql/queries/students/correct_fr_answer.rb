# frozen_string_literal: true

module Queries
  module Students
    class CorrectFrAnswer < StudentQuery
      graphql_name 'Show free response answer for a question'
      description 'Given a response id, show the answer for its associated question'

      argument :response_id, ID, required: true

      type Types::QuestionOptionType, null: false

      def resolve(response_id:)
        Response.find(response_id).question.question_options.find(&:correct)
      end
    end
  end
end
