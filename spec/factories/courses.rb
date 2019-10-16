# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id                 :integer          not null, primary key
#  name               :string
#  teacher_id         :integer
#  standards_chart_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryBot.define do
  factory :course do
    association :teacher, factory: :teacher
    association :standards_chart, factory: :standards_chart
  end
end
