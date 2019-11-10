# frozen_string_literal: true

# == Schema Information
#
# Table name: assignments
#
#  id           :bigint           not null, primary key
#  due          :datetime         indexed
#  instructions :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  deck_id      :bigint           not null, indexed
#  period_id    :bigint           not null, indexed
#

FactoryBot.define do
  factory :assignment do
    association :deck, factory: :deck
    association :period, factory: :period
  end
end
