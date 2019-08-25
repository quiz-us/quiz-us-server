# frozen_string_literal: true

module Mutations
  class EnrollStudent < BaseMutation
    graphql_name 'Enroll Student'
    description 'Enroll Student'

    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :email, String, required: true
    argument :period_id, ID, required: true

    type Types::StudentType

    def resolve(first_name:, last_name:, email:, period_id:)
      teacher_signed_in?
      student = Student.find_by(email: email)
      student ||= Student.create!(
        first_name: first_name,
        last_name: last_name,
        email: email,
        password: SecureRandom.hex(8)
      )
      period = Period.find(period_id)
      Enrollment.create!(
        student: student,
        period: period
      )
      student
    end
  end
end
