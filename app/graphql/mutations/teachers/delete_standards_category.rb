# frozen_string_literal: true

module Mutations
  module Teachers
    class DeleteStandardsCategory < TeacherMutation
      graphql_name 'Delete Standards Category'
      description 'Delete Standards Category description'

      argument :id, ID, required: true

      type Types::StandardsCategoryType

      def resolve(id:)
        # TODO: make this compatible with multiple courses:
        current_teacher.courses.first
                       .standards_chart
                       .standards_categories.find(id).destroy!
      end
    end
  end
end
