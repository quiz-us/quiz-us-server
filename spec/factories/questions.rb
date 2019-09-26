# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  question_text :text
#  question_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  rich_text     :jsonb
#

FactoryBot.define do
  factory :question do
  end
end
