# frozen_string_literal: true

require 'csv'
task clear_staging: :environment do
  clear_staging
end

def clear_staging
  p 'Checking rails env...'
  return unless ENV['RAILS_ENV'] == 'staging'

  Question.destroy_all
  p 'Cleared all questions from staging database'
end
