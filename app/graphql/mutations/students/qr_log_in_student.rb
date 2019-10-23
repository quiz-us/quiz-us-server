# frozen_string_literal: true

module Mutations
  module Students
    # Inherits from BaseMutation because does not requrie student to be logged in:
    class QrLogInStudent < BaseMutation
      graphql_name 'Log in student with qr code'
      description 'Logs student in using qr code'

      # arguments passed to the `resolved` method
      argument :qr_code, String, required: true

      # return type from the mutation
      type Types::StudentType

      def resolve(qr_code:)
        student = Student.find_by(qr_code: qr_code)
        student || GraphQL::ExecutionError.new('Unauthenticated')
      end
    end
  end
end
