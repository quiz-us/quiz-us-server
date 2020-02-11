# frozen_string_literal: true

module Queries
  module Students
    class AssignmentShow < StudentQuery
      graphql_name 'Assignment show'
      description 'Return a Assignment'

      argument :assignment_id, ID, required: true
      argument :student_id, ID, required: true

      type Types::AssignmentType, null: false

      def resolve(assignment_id:, student_id:)
        # check that this student was actually assigned this assignment:
        assignment = current_student.assignments.find(assignment_id)

        {
          id: assignment.id,
          instructions: assignment.instructions,
          due: assignment.due,
          deck: assignment.deck,
          period: assignment.period,
          current_question: Assignments::FindCurrentQuestion.call(
            student_id,
            assignment_id
          ),
          num_correct_responses: assignment.num_correct_responses(student_id),
          num_questions: assignment.num_questions
        }
      end
    end
  end
end
