# frozen_string_literal: true

class SendgridMailer
  def self.send(to, subsitutions, template_name)
    template_id = TEMPLATES[template_name.to_sym]
    unless template_id
      raise StandardError(
        "Sendgrid #{template_name} does not exist. Check the sendgrid_mailer's template map."
      )
    end
    data = {
      "personalizations": [
        {
          "to": [
            {
              "email": to
            }
          ],
          "dynamic_template_data": subsitutions
        }
      ],
      "from": {
        "email": 'no-reply@quizus.org'
      },
      "template_id": template_id
    }
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    begin
      response = sg.client.mail._('send').post(request_body: data)
      return response.status_code
    rescue StandardError => e
      Rollbar.log("Error occured while sending #{template_name} to #{to}", e)
    end
  end

  TEMPLATES = {
    student_log_in: 'd-b7ff4ba285c44f43b4a1c4c6478c2849'
  }.freeze
end
