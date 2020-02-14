# frozen_string_literal: true

# == Schema Information
#
# Table name: question_options
#
#  id          :integer          not null, primary key
#  correct     :boolean
#  option_text :string
#  rich_text   :jsonb
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer          indexed
#
require './spec/helpers/rich_text.rb'

text = Faker::Lorem.sentence
FactoryBot.define do
  factory :question_option do
    association :question
    correct { false }
    rich_text { generate_rich_text(text) }
    trait :correct do
      correct { true }
    end
  end
end

FactoryBot.define do
  factory :mc_option_correct, class: 'QuestionOption' do
    option_text { 'right' }
    correct { true }
    rich_text { generate_rich_text(text) }
    association :question, factory: :mc_question
  end

  factory :mc_option_wrong, class: 'QuestionOption' do
    option_text { 'right' }
    correct { false }
    rich_text { generate_rich_text(text) }
    association :question, factory: :mc_question
  end
end
