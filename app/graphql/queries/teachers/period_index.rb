# frozen_string_literal: true

module Queries
  module Teachers
    class PeriodIndex < TeacherQuery
      description 'Display all periods for current course'

      type [Types::PeriodType], null: false

      def resolve
        current_course.periods
      end
    end
  end
end
