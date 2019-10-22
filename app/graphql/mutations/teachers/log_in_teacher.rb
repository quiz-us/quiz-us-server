# frozen_string_literal: true

module Mutations
  module Teachers
    # Should not inherit from TeacherMutation because teacher shuld not be
    # logged in yet:
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
        return invalid_login unless teacher

        is_valid_for_auth = teacher.valid_for_authentication? do
          teacher.valid_password?(password)
        end
        is_valid_for_auth ? teacher : invalid_login
      end

      def invalid_login
        @invalid_login ||= GraphQL::ExecutionError.new(
          'Incorrect username and/or password. Please try again.'
        )
      end
    end
  end
end
