# frozen_string_literal: true

module Queries
  module Teachers
    class PeriodShow < TeacherQuery
      description 'Displays a period given a period id'

      argument :period_id, ID, required: true
      type Types::PeriodType, null: false

      def resolve(period_id:)
        Period.find(period_id)
      end
    end
  end
end
