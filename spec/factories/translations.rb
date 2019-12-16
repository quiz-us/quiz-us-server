# frozen_string_literal: true

# == Schema Information
#
# Table name: translations
#
#  id          :bigint           not null, primary key
#  count       :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint           not null, indexed, indexed => [student_id]
#  student_id  :bigint           not null, indexed, indexed => [question_id]
#

FactoryBot.define do
  factory :translation do
    association :student, factory: :student
    association :question, factory: :question
    count { 0 }
  end
end
