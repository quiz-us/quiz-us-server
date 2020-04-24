# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  ancestry      :string           indexed
#  question_text :text
#  question_type :string
#  rich_text     :jsonb
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
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
