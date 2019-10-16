# frozen_string_literal: true

module Queries
  module Students
    class AssignmentIndex < BaseQuery
      description 'Display all assignments for current student'

      type [Types::AssignmentType], null: false

      def resolve
        current_student.assignments.map do |a|
          {
            instructions: a.instructions,
            deck: a.deck,
            due: a.due,
            period: a.period,
            responses: a.responses.where(student_id: current_student.id),
            num_questions: a.num_questions
          }
        end
      end
    end
  end
end
