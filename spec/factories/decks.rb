# frozen_string_literal: true

# == Schema Information
#
# Table name: decks
#
#  id          :integer          not null, primary key
#  description :text
#  name        :string
#  owner_type  :string           indexed => [owner_id]
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :bigint           indexed => [owner_type]
#

FactoryBot.define do
  factory :deck do
    association :owner, factory: :student
    name { Faker::Educator.subject }
  end
end
