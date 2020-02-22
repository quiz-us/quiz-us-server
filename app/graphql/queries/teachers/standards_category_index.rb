# frozen_string_literal: true

module Queries
  module Teachers
    class StandardsCategoryIndex < TeacherQuery
      description 'Display all standards categories'

      type [Types::StandardsCategoryType], null: false

      def resolve
        current_course.standards_chart.standards_categories
      end
    end
  end
end
