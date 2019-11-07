# frozen_string_literal: true

# == Schema Information
#
# Table name: periods
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :integer          indexed
#

FactoryBot.define do
  factory :period do
    association :course, factory: :course
    name { Faker::Educator.subject }
  end
end
