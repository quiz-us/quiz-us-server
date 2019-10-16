# frozen_string_literal: true

module Mutations
  module Periods
    class CreatePeriod < BaseMutation
      graphql_name 'Create Period'
      description 'Create Period'

      argument :name, String, required: true

      # return type from the mutation
      type Types::PeriodType

      def resolve(name:)
        period = current_course.periods.create!(name: name)
        period
      end
    end
  end
end
