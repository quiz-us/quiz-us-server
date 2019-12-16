# frozen_string_literal: true

require 'csv'
task clear_staging: :environment do
  clear_staging
end

def clear_staging
  p 'Checking rails env...'
  return unless ENV['RAILS_ENV'] == 'staging'

  Response.destroy_all
  QuestionOption.destroy_all
  Question.destroy_all
  Period.where('created_at > ?', 1.day.ago).destroy_all
  p 'Cleared staging data.'
end
