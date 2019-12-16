# frozen_string_literal: true

# == Schema Information
#
# Table name: standards
#
#  id                    :integer          not null, primary key
#  description           :string           not null
#  meta                  :string
#  title                 :string           not null, indexed => [standards_category_id], indexed
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  standards_category_id :integer          not null, indexed, indexed => [title]
#

FactoryBot.define do
  factory :standard do
    description { Faker::Lorem.paragraph }
    title { Faker::Educator.course_name }
    standards_category
  end
end
