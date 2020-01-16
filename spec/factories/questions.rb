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
require_relative './helpers/rich_text.rb'


FactoryBot.define do
  text = Faker::Lorem.sentence
  factory :question do
    question_type { 'Free Response' }
    question_text { text }
    rich_text { generate_rich_text(text) }
  end

  factory :question_with_no_options, class: 'Question' do
    question_text { text }
    question_type { 'Multiple Choice' }
    rich_text { generate_rich_text(text) }

    factory :mc_question do
      transient do
        wrong_count { 2 }
      end

      # create one correct question option
      after(:create) do |question|
        create :mc_option_correct, question: question
      end

      # create all the other (incorrect) question options
      after(:create) do |question, evaluator|
        create_list(:mc_option_wrong, evaluator.wrong_count, question: question)
      end
    end
  end
end
