# frozen_string_literal: true

FactoryBot.define do
  factory :questions_standard do
    association :question
    association :standard
  end
end
