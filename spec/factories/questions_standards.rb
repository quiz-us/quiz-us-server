# frozen_string_literal: true

# == Schema Information
#
# Table name: questions_standards
#
#  id          :bigint           not null, primary key
#  question_id :integer          not null, indexed => [standard_id], indexed => [standard_id], indexed => [standard_id]
#  standard_id :integer          not null, indexed => [question_id], indexed => [question_id], indexed => [question_id]
#


FactoryBot.define do
  factory :questions_standard do
    association :question
    association :standard
  end
end
