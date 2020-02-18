# frozen_string_literal: true

module Mutations
  module Teachers
    class CreateStandardsCategory < TeacherMutation
      graphql_name 'Create Standards Category'
      description 'Create Standards Category description'

      argument :title, String, required: true
      argument :description, String, required: true

      type Types::StandardsCategoryType

      def resolve(title:, description:)
        # TODO: make this compatible with multiple courses:
        current_teacher.courses.first
                       .standards_chart
                       .standards_categories
                       .create!(title: title, description: description)
      end
    end
  end
end
