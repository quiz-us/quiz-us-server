# frozen_string_literal: true

# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint           not null, primary key
#  period_id  :integer          not null, indexed => [student_id], indexed => [student_id], indexed => [student_id]
#  student_id :integer          not null, indexed => [period_id], indexed => [period_id], indexed => [period_id]
#

FactoryBot.define do
  factory :enrollment do
    association :period, factory: :period
    association :student, factory: :student
  end
end
