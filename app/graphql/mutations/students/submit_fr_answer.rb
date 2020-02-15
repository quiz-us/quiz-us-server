# frozen_string_literal: true

module Mutations
  module Students
    class SubmitFrAnswer < StudentMutation
      graphql_name 'Submit response text for a free response question'
      description 'Submit response text for a free response question'

      argument :response_id, ID, required: true
      argument :response_text, String, required: true

      type Types::ResponseType

      def resolve(response_id:, response_text:)
        response = Response.find(response_id)
        response.update!(response_text: response_text)

        response
      end
    end
  end
end
