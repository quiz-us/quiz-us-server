# frozen_string_literal: true

# == Schema Information
#
# Table name: standards_categories
#
#  id                 :integer          not null, primary key
#  description        :text
#  title              :string           not null, indexed => [standards_chart_id], indexed
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  standards_chart_id :integer          not null, indexed, indexed => [title]
#

class StandardsCategory < ApplicationRecord
  belongs_to :standards_chart
  has_many :standards, dependent: :destroy

  validates :description, :standards_chart, :title, presence: true
  validates :title, uniqueness: { scope: :standards_chart_id }
end
