# frozen_string_literal: true

# == Schema Information
#
# Table name: standards
#
#  id                    :integer          not null, primary key
#  description           :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  standards_category_id :integer          not null
#  title                 :string           not null
#  meta                  :string
#

class Standard < ApplicationRecord
  belongs_to :standards_category
  delegate :standards_chart, to: :standards_category, allow_nil: false

  has_many :questions_standards, dependent: :destroy
  has_many :questions, through: :questions_standards
  has_many :responses, through: :questions

  validates :description, :standards_category, :title, presence: true
  validates :title, uniqueness: { scope: :standards_category_id }
end
