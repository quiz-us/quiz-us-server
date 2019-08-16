# frozen_string_literal: true

# == Schema Information
#
# Table name: standards
#
#  id                    :integer          not null, primary key
#  description           :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  standards_category_id :integer          not null
#  title                 :string           not null
#  meta                  :string
#

FactoryBot.define do
  factory :standard do
    description { Faker::Lorem.paragraph }
    title { Faker::Educator.course_name }
    standards_category
  end
end
