# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id                 :integer          not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  standards_chart_id :integer          indexed
#  teacher_id         :integer          indexed
#

FactoryBot.define do
  factory :course do
    association :teacher, factory: :teacher
    association :standards_chart, factory: :standards_chart
  end
end
