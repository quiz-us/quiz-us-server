# frozen_string_literal: true

module Queries
  module Teachers
    class StandardIndex < TeacherQuery
      description 'Display all standards'

      type [Types::StandardType], null: false

      def resolve
        current_course.standards.includes(:standards_category)
      end
    end
  end
end
