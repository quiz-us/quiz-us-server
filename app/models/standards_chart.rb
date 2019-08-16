# frozen_string_literal: true

# == Schema Information
#
# Table name: standards_charts
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StandardsChart < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :standards_categories, dependent: :destroy
  has_many :standards, through: :standards_categories
end
