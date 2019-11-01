# == Schema Information
#
# Table name: question_options
#
#  id          :integer          not null, primary key
#  question_id :integer
#  option_text :string
#  correct     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  rich_text   :jsonb
#

FactoryBot.define do
  factory :mc_option_correct, class: 'QuestionOption' do 
    option_text { "right" }
    correct { true }
    rich_text { "{\"object\":\"value\",\"document\":{\"object\":\"document\",\"data\":{},\"nodes\":[{\"object\":\"block\",\"type\":\"line\",\"data\":{},\"nodes\":[{\"object\":\"text\",\"text\":\"right\",\"marks\":[]}]}]}}" }
    association :question
  end 

  factory :mc_option_wrong, class: 'QuestionOption' do 
    option_text { "right" }
    correct { false }
    rich_text { "{\"object\":\"value\",\"document\":{\"object\":\"document\",\"data\":{},\"nodes\":[{\"object\":\"block\",\"type\":\"line\",\"data\":{},\"nodes\":[{\"object\":\"text\",\"text\":\"right\",\"marks\":[]}]}]}}" }
    association :question
  end 
end 