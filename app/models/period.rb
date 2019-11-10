# frozen_string_literal: true

# == Schema Information
#
# Table name: periods
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :integer          indexed
#

class Period < ApplicationRecord
  validates :name, presence: true
  belongs_to :course
  delegate :standards_chart, to: :course
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments
  has_many :assignments, dependent: :destroy
end
