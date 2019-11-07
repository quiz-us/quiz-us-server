# frozen_string_literal: true

module Mutations
  module Teachers
    # Should not inherit from TeacherMutation because teacher shuld not be
    # logged in yet:
    class SignUpTeacher < BaseMutation
      graphql_name 'Sign Up Teacher'
      description 'Signs teacher up for an account'

      # arguments passed to the `resolved` method
      argument :email, String, required: true
      argument :password, String, required: true

      # return type from the mutation
      type Types::TeacherType

      def resolve(email:, password:)
        Teacher.create!(
          email: email,
          password: password
        )
      end
    end
  end
end
