# frozen_string_literal: true

module Mutations
  module Auth
    class LogInStudent < BaseMutation
      graphql_name 'Log in student'
      description 'Logs student in'

      # arguments passed to the `resolved` method
      argument :token, String, required: true

      # return type from the mutation
      type Types::StudentType

      def resolve(token:)
        student = Token.authenticate(token)
        student || GraphQL::ExecutionError.new('Unauthenticated')
      end
    end
  end
end
