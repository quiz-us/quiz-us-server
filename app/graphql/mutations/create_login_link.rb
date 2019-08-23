# frozen_string_literal: true

require 'launchy'

module Mutations
  class CreateLoginLink < BaseMutation
    graphql_name 'Create Login Link'
    description 'Create Login Link'

    # arguments passed to the `resolved` method
    argument :email, String, required: true

    # return type from the mutation
    type Boolean

    def resolve(email:)
      # student = Student.find_by!(email: email)
      # token = student.tokens.create!
      # log_in_base = Rails.env.production ? 'https://quizus.fun' : 'https://localhost:8080'
      # SendgridMailer.send(
      #   to: email,
      #   substituions: {
      #     first_name: student.first_name,
      #     log_in_url: "#{log_in_base}/auth?token=#{token}"
      #   },
      #   template_name: :student_log_in
      # )
    end
  end
end
