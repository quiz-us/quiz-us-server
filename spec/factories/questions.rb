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
  factory :question_with_no_options, class: 'Question' do 
    text = Faker::Lorem.sentence
    question_text { text }
    question_type { "Multiple Choice" }
    rich_text { "{\"object\":\"value\",\"document\":{\"object\":\"document\",\"data\":{},\"nodes\":[{\"object\":\"block\",\"type\":\"line\",\"data\":{},\"nodes\":[{\"object\":\"text\",\"text\":\"#{text}\",\"marks\":[]}]}]}}" }

    factory :mc_question do 
      transient do 
        wrong_count { 2 }
      end 

      # create one correct question option
      after(:create) do |question|
        create :mc_option_correct, question: question
      end 
      
      # create all the other (incorrect) question options
      after(:create) do |question, evaluator|
        create_list(:mc_option_wrong, evaluator.wrong_count, question: question)
      end
    end 
  end 
end