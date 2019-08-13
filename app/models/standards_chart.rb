# frozen_string_literal: true

class StandardsChart < ApplicationRecord
  has_many :standards_categories, dependent: :destroy
  has_many :standards, through: :standards_categories
end
