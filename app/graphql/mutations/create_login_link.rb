# frozen_string_literal: true

module Mutations
  class CreateLoginLink < BaseMutation
    graphql_name 'Create student login link'
    description 'Create login link for student'

    # arguments passed to the `resolved` method
    argument :email, String, required: true

    # return type from the mutation
    type Boolean

    def resolve(email:)
      student = Student.find_by!(email: email)
      token = student.tokens.create!
      log_in_base = Rails.env.production? ? 'https://quizus.fun' : 'http://localhost:8080'
      SendgridMailer.send(
        to: email,
        substitutions: {
          first_name: student.first_name,
          log_in_url: "#{log_in_base}/auth?token=#{token.value}"
        },
        template_name: :student_log_in
      )
    end
  end
end
