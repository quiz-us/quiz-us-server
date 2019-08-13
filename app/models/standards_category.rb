# frozen_string_literal: true

class StandardsCategory < ApplicationRecord
  belongs_to :standards_chart
  has_many :standards, dependent: :destroy

  validates :description, :standards_chart, :title, presence: true
  validates :title, uniqueness: { scope: :standards_chart_id }
end
