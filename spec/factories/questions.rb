# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  question_text :text
#  question_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  rich_text     :jsonb
#
require './spec/helpers/rich_text.rb'

FactoryBot.define do
  text = Faker::Lorem.sentence
  factory :question do
    question_type { 'Free Response' }
    question_text { text }
    rich_text { generate_rich_text(text) }

    factory :mc_question do
      question_type { 'Multiple Choice' }
    end
  end
end
