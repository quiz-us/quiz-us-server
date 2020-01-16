# frozen_string_literal: true

# == Schema Information
#
# Table name: taggings
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer          indexed => [tag_id]
#  tag_id      :integer          indexed => [question_id]
#

FactoryBot.define do
  factory :tagging do
    association :question, factory: :question
    association :tag, factory: :tag
  end
end
