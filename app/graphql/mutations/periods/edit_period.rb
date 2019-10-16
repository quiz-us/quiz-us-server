# frozen_string_literal: true

module Mutations
  module Periods
    class EditPeriod < BaseMutation
      graphql_name 'Edit Period'
      description 'Edit Period'

      argument :period_id, ID, required: true
      argument :name, String, required: true

      # return type from the mutation
      type Types::PeriodType

      def resolve(period_id:, name:)
        period = current_course.periods.find(period_id)
        period.update!(name: name)
        period
      end
    end
  end
end
