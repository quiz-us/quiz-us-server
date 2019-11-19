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
    class StudentAssignmentResults < BaseQuery
      graphql_name 'Student Assignment Results'
      description 'Given an assignment id and student id, show how students did on that specific assignment'

      argument :assignment_id, ID, required: true
      argument :student_id, ID, required: true

      type [Types::ResponseType], null: false

      def resolve(assignment_id:, student_id:)
        questions = Assignment.find(assignment_id).deck.questions
        student_responses = Hash.new { |h, k| h[k] = [] }
        Response.includes(:question_option).where(
          assignment_id: assignment_id,
          student_id: student_id
        ).each { |r| student_responses[r.question_id] << r.as_json.merge(question_option: r.question_option.rich_text) }
        res = []
        questions.each do |q|
          responses = student_responses[q.id].map do |r|
            byebug
            answer = r[:question_option] || r[:response_text]
            {
              answer: answer,
              correct: r.mc_correct,
              self_grade: r.self_grade
            }
          end
          res << {
            question: q,
            responses: responses
          }
        end
        byebug
      end
    end
  end
end
