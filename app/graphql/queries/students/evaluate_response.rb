# frozen_string_literal: true

require 'json'

module Queries
  module Students
    class EvaluateResponse < StudentQuery
      description 'Evaluate free response'

      argument :response_id, ID, required: true
      argument :response_text, String, required: true

      type Types::EvaluationType, null: false

      def resolve(response_id:, response_text:)
        solution_text = Response.find(response_id)
                                .question.correct_answer
                                .option_text
        res = CompareText.call(solution_text, response_text)
        res = JSON.parse(res)
        { percent: (res['similarity'] * 100).round(1) }
      end
    end
  end
end
