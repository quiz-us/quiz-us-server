# frozen_string_literal: true

module Mutations
  module Teachers
    class UnenrollStudent < TeacherMutation
      graphql_name 'Unenroll Student'
      description 'Unenroll Student'

      argument :student_id, ID, required: true
      argument :period_id, ID, required: true

      # return type from the mutation
      type Types::StudentType

      def resolve(student_id:, period_id:)
        unless current_teacher.periods.find_by(id: period_id)
          raise GraphQL::ExecutionError,
                'You can only unenroll students in your classes'
        end

        Enrollment.find_by!(student_id: student_id, period_id: period_id).destroy

        Student.find(student_id)
      end
    end
  end
end
