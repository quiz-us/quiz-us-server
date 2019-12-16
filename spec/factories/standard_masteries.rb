# == Schema Information
#
# Table name: standard_masteries
#
#  id           :bigint           not null, primary key
#  num_attempts :integer          default(0), not null
#  num_correct  :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  standard_id  :bigint           not null, indexed, indexed => [student_id]
#  student_id   :bigint           not null, indexed, indexed => [standard_id]
#

FactoryBot.define do
  factory :standard_mastery do
    association :student, factory: :student
    association :standard, factory: :standard
  end
end
