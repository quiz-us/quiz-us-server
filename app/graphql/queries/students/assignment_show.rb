# frozen_string_literal: true

module Queries
  module Students
    class AssignmentShow < BaseQuery
      graphql_name 'Assignment show'
      description 'Return a Assignment'

      argument :assignment_id, ID, required: true

      type Types::AssignmentType, null: false

      def resolve(assignment_id:)
        Assignment.find(assignment_id)
      end
    end
  end
end
