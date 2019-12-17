# frozen_string_literal: true

# == Schema Information
#
# Table name: periods
#
#  id         :integer          not null, primary key
#  name       :string           not null, indexed => [course_id]
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :integer          indexed, indexed => [name]
#

class Period < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { scope: %i[course_id] }

  belongs_to :course
  delegate :standards_chart, to: :course
  has_many :standards, through: :course
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments
  has_many :assignments, dependent: :destroy
end
