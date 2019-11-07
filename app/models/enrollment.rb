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
  validates :period_id, uniqueness: { scope: :student_id }
  validates :period, :student, presence: true
end
