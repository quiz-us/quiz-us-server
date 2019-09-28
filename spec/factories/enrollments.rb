# frozen_string_literal: true

# == Schema Information
#
# Table name: enrollments
#
#  period_id  :integer          not null
#  student_id :integer          not null
#  id         :bigint           not null, primary key
#

FactoryBot.define do
  factory :enrollment do
    association :period, factory: :period
    association :student, factory: :student
  end
end
