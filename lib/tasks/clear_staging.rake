# frozen_string_literal: true

require 'csv'
task clear_staging: :environment do
  return unless ENV['RAILS_ENV'] == 'staging'

  Question.destroy_all
end
