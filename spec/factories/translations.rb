# frozen_string_literal: true

# == Schema Information
#
# Table name: translations
#
#  id          :bigint           not null, primary key
#  count       :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint           not null, indexed
#  student_id  :bigint           not null, indexed
#

FactoryBot.define do
  factory :translation do
    association :student, factory: :student
    association :question, factory: :question
    count { 0 }
  end
end
