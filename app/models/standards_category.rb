# frozen_string_literal: true

class StandardsCategory < ApplicationRecord
  belongs_to :standards_chart
  has_many :standards, dependent: :destroy
end
