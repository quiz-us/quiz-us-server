# frozen_string_literal: true

module Mutations
  module Teachers
    class CreateCourse < TeacherMutation
      graphql_name 'Create Course'
      description 'Create Course'

      argument :title, String, required: true

      # return type from the mutation
      type Types::CourseType

      def resolve(title:)
        standards_chart = StandardsChart.create!(title: title)
        Course.create!(
          name: title,
          teacher: current_teacher,
          standards_chart: standards_chart
        )
      end
    end
  end
end
