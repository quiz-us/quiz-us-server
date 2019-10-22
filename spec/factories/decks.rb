# frozen_string_literal: true

# == Schema Information
#
# Table name: decks
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_type  :string
#  owner_id    :bigint
#

FactoryBot.define do
  factory :deck do
    association :owner, factory: :student
    name { Faker::Educator.subject }
  end
end
