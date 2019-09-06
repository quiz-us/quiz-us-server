# frozen_string_literal: true

module Queries
  class AssignmentShow < BaseQuery
    graphql_name 'Assignment show'
    description 'Return an Assignment'

    argument :assignment_id, ID, required: true

    type Types::AssignmentType, null: false

    def resolve(assignment_id:)
      current_teacher.assignments.find(assignment_id)
    end
  end
end
