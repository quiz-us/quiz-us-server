# frozen_string_literal: true

# == Schema Information
#
# Table name: periods
#
#  id         :integer          not null, primary key
#  name       :string
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :period do
    association :course, factory: :course
  end
end
