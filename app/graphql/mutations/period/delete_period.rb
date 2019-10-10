# frozen_string_literal: true

module Mutations
  module Period
    class DeletePeriod < BaseMutation
      graphql_name 'Delete Period'
      description 'Delete Period'

      argument :period_id, ID, required: true

      # return type from the mutation
      type Types::PeriodType

      def resolve(period_id:)
        current_course.periods.find(period_id).destroy!
      end
    end
  end
end
