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
    teacher = Teacher.create!(
      email: email,
      password: SecureRandom.hex(8),
      onboarded: false
    )
    title = "#{email}'s course"
    standards_chart = StandardsChart.create!(title: title)
    course = Course.create(
      name: "#{email}'s course",
      standards_chart: standards_chart,
      teacher: teacher
    )
    StandardsCategory.create!(
      title: 'General',
      description: 'All-Purpose Category: Everything can go in here!',
      standards_chart: standards_chart
    )
    Period.create!(
      name: 'Your First Class',
      course: course
    )
    teacher
  end
end
