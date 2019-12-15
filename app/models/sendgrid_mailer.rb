# frozen_string_literal: true

class SendgridMailer
  def self.send(to:, substitutions:, template_name:)
    template_id = TEMPLATES[template_name.to_sym]
    unless template_id
      raise StandardError(
        "Sendgrid #{template_name} does not exist. Check the sendgrid_mailer's template map."
      )
    end
    if Rails.env.development?
      stub_development(to, substitutions, template_name)
      return true
    end

    to = 'lingjoshuas@gmail.com' if ENV['RAILS_ENV'] == 'staging'
    data = {
      "personalizations": [
        {
          "to": [
            {
              "email": to
            }
          ],
          "dynamic_template_data": substitutions
        }
      ],
      "from": {
        "email": 'no-reply@quizus.org'
      },
      "template_id": template_id
    }
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    begin
      sg.client.mail._('send').post(request_body: data)
      true
    rescue StandardError => e
      Rollbar.log("Error occured while sending #{template_name} to #{to}", e)
      false
    end
  end

  def self.stub_development(to, substitutions, template_name)
    substitutions_html = '<ul>'
    substitutions.each do |k, v|
      value = if v.start_with?('http')
                "<a href=#{v} target_blank>#{v}</a>"
              else
                "<span>#{v}</span>"
              end
      substitutions_html += <<-HTML
        <li>
          <strong>#{k}</strong>: #{value}
        </li>
      HTML
    end
    substitutions_html += '</ul>'

    File.open(Rails.root.join('tmp', 'mailer.html'), 'w') do |f|
      f.write(
        <<-HTML
        <div>
          <strong>To: </strong>#{to}
        </div>
        HTML
      )
      f.write(
        <<-HTML
        <div>
          <strong>Substitutions: </strong>
          #{substitutions_html}
        </div>
        HTML
      )
      f.write(
        <<-HTML
        <div>
          <strong>Template Name: </strong>#{template_name}
        </div>
        HTML
      )
    end
    Launchy.open(Rails.root.join('tmp', 'mailer.html').to_s)
  end

  TEMPLATES = {
    student_log_in: 'd-b7ff4ba285c44f43b4a1c4c6478c2849'
  }.freeze
end
