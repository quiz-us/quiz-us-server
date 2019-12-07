# frozen_string_literal: true

module Queries
  module Students
    class StandardsMastery < StudentQuery
      graphql_name 'Student standards mastery'
      description 'How a student is performing on each standard'

      type [Types::StandardsMasteryType], null: false

      def resolve
        result = {}
        current_student.responses.each do |response|
          response.standards.each do |standard|
            if result[standard.id]
              result[standard.id][:num_attempted] += 1
              result[standard.id][:num_correct] += 1 if response.correct
            else
              result[standard.id] = {
                standard: standard,
                num_attempted: 1,
                num_correct: response.correct ? 1 : 0
              }
            end
          end
        end

        results = []
        result.each do |_, v|
          results << v
        end

        results
      end
    end
  end
end
