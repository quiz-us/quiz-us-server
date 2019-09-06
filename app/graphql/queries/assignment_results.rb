# frozen_string_literal: true

module Queries
  class AssignmentResults < BaseQuery
    graphql_name 'Assignment Results'
    description 'Given an assignment id, return the results grouped by students'

    argument :assignment_id, ID, required: true

    type [Types::AssignmentResultType], null: false

    def resolve(assignment_id:)
      # teacher_signed_in?
      results = []
      students = Assignment.find(assignment_id)
                           .period
                           .students
                           .includes(:responses, responses: :question)
      students.each do |student|
        result = {
          fullname: "#{student.first_name} #{student.last_name}",
          answer: []
        }
        student.responses.where(assignment_id: assignment_id).each do |response|
          q = response.question
          result[:answer] << {
            questionId: q.id,
            questionType: q.question_type,
            questionText: q.question_text,
            responseText: (
              response.response_text ||
              QuestionOption.find(response.question_option_id).option_text
            ),
            selfGrade: response.self_grade,
            mcCorrect: response.mc_correct
          }
        end
        result[:answer] = result[:answer].to_json
        results << result
      end
      results
    end
  end
end
