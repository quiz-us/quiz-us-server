# frozen_string_literal: true

# GetCurrentTeacher parses the email out of the access token and finds
# or creates the teacher by email
class GetCurrentTeacher
  include Callable

  attr_reader :request

  def initialize(request)
    @request = request
  end

  def call
    email = auth_token[0]['https://quizushq.org/email']
    Teacher.find_by(email: email) || create_teacher(email)
  rescue JWT::DecodeError
    nil
  end

  private

  def http_token
    if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    end
  end

  def auth_token
    JsonWebToken.verify(http_token)
  end

  def create_teacher(email)
    Teacher.create!(
      email: email,
      password: SecureRandom.hex(8)
    )
  end
end
