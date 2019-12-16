# frozen_string_literal: true

# == Schema Information
#
# Table name: responses
#
#  id                 :integer          not null, primary key
#  mc_correct         :boolean          indexed
#  response_text      :text
#  self_grade         :integer          indexed
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  assignment_id      :integer
#  question_id        :integer          not null
#  question_option_id :integer          indexed
#  student_id         :integer          not null, indexed
#

FactoryBot.define do
  factory :response do
    association :question, factory: :question
    association :student, factory: :student

    trait :multiple_choice_correct do
      association :question_option, factory: %i[question_option correct]
      mc_correct { true }
    end

    trait :multiple_choice_incorrect do
      association :question_option, factory: %i[question_option]
      mc_correct { false }
    end

    trait :free_response_correct do
      # free response is considered correct if rating is >= 4
      self_grade { 4 }
    end

    trait :free_response_incorrect do
      self_grade { 3 }
    end
  end
end
