# frozen_string_literal: true

module Queries
  module Students
    class AssignmentIndex < StudentQuery
      description 'Display all assignments for current student'

      type [Types::AssignmentType], null: false

      def resolve
        current_student.assignments.map do |a|
          {
            id: a.id,
            instructions: a.instructions,
            deck: a.deck,
            due: a.due,
            period: a.period,
            responses: a.responses.where(student_id: current_student.id),
            num_questions: a.num_questions,
            num_correct_responses: a.num_correct_responses(current_student.id)
          }
        end.sort do |a, b|
          a_percentage = a[:num_correct_responses] / a[:num_questions]
          b_percentage = b[:num_correct_responses] / b[:num_questions]
          a_percentage <=> b_percentage
        end
      end
    end
  end
end
