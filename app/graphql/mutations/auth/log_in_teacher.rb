# frozen_string_literal: true

module Mutations
  module Auth
    class LogInTeacher < BaseMutation
      graphql_name 'Log in teacher '
      description 'Logs teacher in'

      # arguments passed to the `resolved` method
      argument :email, String, required: true
      argument :password, String, required: true

      # return type from the mutation
      type Types::TeacherType

      def resolve(email:, password:)
        teacher = Teacher.find_for_authentication(email: email)
        return nil unless teacher

        is_valid_for_auth = teacher.valid_for_authentication? do
          teacher.valid_password?(password)
        end
        is_valid_for_auth ? teacher : nil
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new(
          "Invalid input: #{e.record.errors.full_messages.join(', ')}"
        )
      end
    end
  end
end
