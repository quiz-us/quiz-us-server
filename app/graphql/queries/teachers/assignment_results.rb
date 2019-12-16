# frozen_string_literal: true

module Queries
  module Teachers
    class AssignmentResults < TeacherQuery
      graphql_name 'Assignment Results'
      description 'Given an assignment id, return the results grouped by students'

      argument :assignment_id, ID, required: true

      type [Types::AssignmentResultType], null: false

      def resolve(assignment_id:)
        results = []
        students = Assignment.find(assignment_id)
                             .period
                             .students
                             .includes(:responses, responses: :question)
        students.each do |student|
          student_performance = {
            firstname: student.first_name,
            lastname: student.last_name,
            student_id: student.id
          }
          responses = student.responses.where(assignment_id: assignment_id)
          total_num_responses = responses.count

          total_correct = responses.correct.count
          student_performance[:result] = "#{total_correct} / #{total_num_responses}"
          results << student_performance
        end
        results
      end
    end
  end
end
