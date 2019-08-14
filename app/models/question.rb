# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  question_text :text
#  question_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  question_node :string           not null
#

class Question < ApplicationRecord
  has_many :taggings

  has_many :tags,
    through: :taggings,
    source: :tag
  
  has_many :questions_standards,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :QuestionsStandard

  has_many :standards,
    through: :questions_standards,
    source: :standard
end
