# frozen_string_literal: true

module Queries
  module Students
    class AssignmentShow < BaseQuery
      graphql_name 'Assignment show'
      description 'Return a Assignment'

      argument :assignment_id, ID, required: true
      argument :student_id, ID, required: true

      type Types::AssignmentType, null: false

      def resolve(assignment_id:, student_id:)
        # check that this student was actually assigned this assignment:
        current_student.assignments.find(assignment_id)
      end
    end
  end
end
