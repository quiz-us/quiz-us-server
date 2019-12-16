# frozen_string_literal: true

namespace :mastery do
  # WARNING: This rake task is NOT idempotent and it should be a ONE TIME rake
  # task to create standard_masteries records from student responses.
  task calibrate: :environment do
    p 'Generating standard_masteries from student responses...'
    Student.all.each do |student|
      p "Creating standard_masteries for #{student.email}"
      student.responses.each do |response|
        response.calculate_mastery!(student)
      end
    end
    p 'Done creating standard_masteries!'
  end
end
