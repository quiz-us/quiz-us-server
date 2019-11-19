# frozen_string_literal: true

# Question number 1: what is an atom?
#
# Attempt number 1: 'it is a molecule'
# self-assessment: 3
# answered at: timestamp
#
# Attempt number 2: 'it is the basic building block of life'
# self-assessment: 4
# answered at: timestamp

module Queries
  module Teachers
    class StudentAssignmentResults < TeacherQuery
      graphql_name 'Student Assignment Results'
      description 'Given an assignment id and student id, show how students did on that specific assignment'

      argument :assignment_id, ID, required: true
      argument :student_id, ID, required: true

      type [Types::QuestionType], null: false

      def resolve(assignment_id:, student_id:)
        questions = Assignment.find(assignment_id).deck.questions
        student_responses = find_student_responses(assignment_id, student_id)
        questions_with_responses = []
        questions.each do |q|
          questions_with_responses << q.as_json.merge(
            responses: student_responses[q.id]
          )
        end
        questions_with_responses
      end

      private

      def find_student_responses(assignment_id, student_id)
        student_responses = Hash.new { |h, k| h[k] = [] }
        Response.includes(:question_option).where(
          assignment_id: assignment_id,
          student_id: student_id
        ).each do |r|
          student_responses[r.question_id] << r.as_json.merge(
            created_at: r.created_at,
            question_option: r.question_option,
            response_text: r.response_text,
            correct: r.mc_correct,
            self_grade: r.self_grade
          )
        end
        student_responses
      end
    end
  end
end
