# frozen_string_literal: true

module Queries
  module Teachers
    class CourseIndex < TeacherQuery
      description 'Display all courses that belong to the current teacher'

      type [Types::CourseType], null: false

      def resolve
        current_teacher.courses
      end
    end
  end
end
