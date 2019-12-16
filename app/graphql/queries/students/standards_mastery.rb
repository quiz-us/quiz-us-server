# frozen_string_literal: true

module Queries
  module Students
    class StandardsMastery < StudentQuery
      graphql_name 'Student standards mastery'
      description 'How a student is performing on each standard'

      type [Types::StandardsMasteryType], null: false

      def resolve
        result = {}
        current_student.standard_masteries.includes(:standard).each do |mastery|
          standard = mastery.standard
          result[standard.id] = {
            standard: standard,
            num_attempted: mastery.num_attempts,
            num_correct: mastery.num_correct
          }
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
