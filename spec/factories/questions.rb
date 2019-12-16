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
    question_type { 'Free Response' }
    question_text { 'here is a question' }
    rich_text do
      {
        object: 'value',
        document: {
          object: 'document',
          data: {},
          nodes: [{
            object: 'block',
            type: 'line',
            data: {},
            nodes: [{ object: 'text', text: 'here is a question', marks: [] }]
          }]
        }
      }.to_json
    end
  end
end
