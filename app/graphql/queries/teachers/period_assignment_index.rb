# frozen_string_literal: true

module Queries
  module Teachers
    class PeriodAssignmentIndex < TeacherQuery
      description 'Display all assignments for a period'

      argument :period_id, ID, required: true
      type [Types::AssignmentType], null: false

      def resolve(period_id:)
        current_course.periods.find(period_id).assignments
      end
    end
  end
end
