# frozen_string_literal: true

class Standard < ApplicationRecord
  belongs_to :standards_category
  delegate :standards_chart, to: :standards_category, allow_nil: false
end
