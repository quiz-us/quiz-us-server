# frozen_string_literal: true

# == Schema Information
#
# Table name: standards
#
#  id                 :integer          not null, primary key
#  standards_chart_id :integer
#  text               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Standard < ApplicationRecord
  belongs_to :standards_category
  delegate :standards_chart, to: :standards_category, allow_nil: false

  has_many :questions_standards,
           primary_key: :id,
           foreign_key: :standard_id,
           class_name: :QuestionsStandard

  has_many :questions,
           through: :questions_standards,
           source: :question

  validates :description, :standards_category, :title, presence: true
  validates :title, uniqueness: { scope: :standards_category_id }
end
