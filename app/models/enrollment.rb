# frozen_string_literal: true

# == Schema Information
#
# Table name: enrollments
#
#  period_id  :integer          not null
#  student_id :integer          not null
#  id         :bigint           not null, primary key
#


class Enrollment < ApplicationRecord
  belongs_to :period
  belongs_to :student
  validates :period_id, uniqueness: { scope: :student_id }
end
