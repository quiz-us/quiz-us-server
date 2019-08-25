# frozen_string_literal: true

module Queries
  module Students
    class AssignmentIndex < BaseQuery
      description 'Display all assignments for current student'

      type [Types::AssignmentType], null: false

      def resolve
        current_student.assignments
      end
    end
  end
end
