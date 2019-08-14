# frozen_string_literal: true

# == Schema Information
#
# Table name: standards_categories
#
#  id                 :integer          not null, primary key
#  title              :string           not null
#  description        :text
#  standards_chart_id :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryBot.define do
  factory :standards_category do
    title { Faker::Educator.subject }
    description { Faker::Lorem.paragraph }
    standards_chart
  end
end
