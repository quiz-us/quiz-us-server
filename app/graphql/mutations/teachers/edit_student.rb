# frozen_string_literal: true

module Mutations
  module Teachers
    class EditStudent < TeacherMutation
      graphql_name 'Edit Student'
      description 'Edit Student'

      argument :student_id, ID, required: true
      argument :student_params, Types::StudentParamsType, required: false

      # return type from the mutation
      type Types::StudentType

      def resolve(student_id:, student_params:)
        student = Student.find(student_id)
        student.update!(student_params.to_h)

        student
      end
    end
  end
end
