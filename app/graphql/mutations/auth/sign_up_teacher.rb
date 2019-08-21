# frozen_string_literal: true

module Mutations
  module Auth
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

      # sample mutation
      # mutation {
      #   signUpTeacher(email: "test@example.com", password: "password1243") {
      #     email
      #     id
      #   }
      # }
    end
  end
end
