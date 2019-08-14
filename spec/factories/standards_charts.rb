# frozen_string_literal: true

# == Schema Information
#
# Table name: standards_charts
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :standards_chart do
    title { Faker::Educator.secondary_school + ' ' + Faker::Educator.subject }
  end
end
