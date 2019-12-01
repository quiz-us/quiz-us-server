# frozen_string_literal: true

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
          num_responses = student_responses[q.id].length
          questions_with_responses << q.as_json.merge(
            responses: student_responses[q.id],
            num_responses: num_responses
          )
        end
        questions_with_responses.sort! do |a, b|
          b[:num_responses] <=> a[:num_responses]
        end
      end

      private

      def find_student_responses(assignment_id, student_id)
        student_responses = Hash.new { |h, k| h[k] = [] }
        Response.includes(:question_option).order(created_at: :asc).where(
          assignment_id: assignment_id,
          student_id: student_id
        ).each do |r|
          student_responses[r.question_id] << r.as_json.merge(
            question_option: r.question_option
          )
        end
        student_responses
      end
    end
  end
end
