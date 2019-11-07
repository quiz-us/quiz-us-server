# frozen_string_literal: true

module Mutations
  module Students
    # Inherits from BaseMutation because does not requrie student to be logged in:
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
        log_in_base = case ENV['RAILS_ENV']
                      when 'production'
                        'https://quizus.org'
                      when 'staging'
                        'https://staging.quizus.org'
                      else
                        'http://localhost:8080'
                      end
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
end
