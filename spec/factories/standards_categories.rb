# frozen_string_literal: true

# == Schema Information
#
# Table name: standards_categories
#
#  id                 :integer          not null, primary key
#  description        :text
#  title              :string           not null, indexed => [standards_chart_id], indexed
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  standards_chart_id :integer          not null, indexed, indexed => [title]
#

FactoryBot.define do
  factory :standards_category do
    title { Faker::Educator.subject }
    description { Faker::Lorem.paragraph }
    association :standards_chart, factory: :standards_chart
  end
end
