# frozen_string_literal: true

module Queries
  module Teachers
    class AssignmentShow < TeacherQuery
      graphql_name 'Assignment show'
      description 'Return an Assignment'

      argument :assignment_id, ID, required: true

      type Types::AssignmentType, null: false

      def resolve(assignment_id:)
        current_teacher.assignments.find(assignment_id)
      end
    end
  end
end
