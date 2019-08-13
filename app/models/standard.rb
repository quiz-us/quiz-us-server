# frozen_string_literal: true

class Standard < ApplicationRecord
  belongs_to :standards_category
  delegate :standards_chart, to: :standards_category, allow_nil: false

  validates :description, :standards_category, :title, presence: true
  validates :title, uniqueness: { scope: :standards_category_id }
end
