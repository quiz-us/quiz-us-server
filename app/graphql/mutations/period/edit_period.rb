# frozen_string_literal: true

module Mutations
  module Period
    class EditPeriod < BaseMutation
      graphql_name 'Edit Period'
      description 'Edit Period'

      argument :name, String, required: true
      argument :period_id, ID, required: true

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
