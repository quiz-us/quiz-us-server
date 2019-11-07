# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id                 :integer          not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  standards_chart_id :integer          indexed
#  teacher_id         :integer          indexed
#

class Course < ApplicationRecord
  belongs_to :teacher
  belongs_to :standards_chart
  has_many :standards, through: :standards_chart
  has_many :questions_standards, through: :standards
  has_many :questions, through: :questions_standards
  has_many :periods, dependent: :destroy
end
