# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  question_text :text
#  question_type :string
#  question_node :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Question < ApplicationRecord
  include PgSearch

  pg_search_scope :search_for,
                  against: %i[question_text],
                  using: { tsearch: { any_word: true, prefix: true } }

  has_many :question_options, dependent: :destroy
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

  has_many :question_options,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :QuestionOption
end
