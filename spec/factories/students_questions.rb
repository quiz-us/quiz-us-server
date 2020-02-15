# frozen_string_literal: true

# == Schema Information
#
# Table name: students_questions
#
#  id                      :bigint           not null, primary key
#  e_factor                :float            default(2.5), not null
#  next_due                :datetime         not null, indexed
#  num_consecutive_correct :integer          default(0), not null
#  total_attempts          :integer          default(0), not null
#  total_correct           :integer          default(0), not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  question_id             :bigint           not null, indexed
#  student_id              :bigint           not null, indexed
#

FactoryBot.define do
  factory :students_question do
    association :question
    association :student
    next_due { Faker::Date.forward(days: 30) }
    num_consecutive_correct { 2 }
    total_attempts { 4 }
    total_correct { 3 }
  end
end
