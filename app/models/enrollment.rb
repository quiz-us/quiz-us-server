# frozen_string_literal: true

# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint           not null, primary key
#  period_id  :integer          not null, indexed => [student_id], indexed => [student_id], indexed => [student_id]
#  student_id :integer          not null, indexed => [period_id], indexed => [period_id], indexed => [period_id]
#

class Enrollment < ApplicationRecord
  belongs_to :period
  belongs_to :student
  validates :student, uniqueness: {
    scope: :period_id,
    message: 'with this email is already in this class.'
  }
  validates :period, :student, presence: true
end
