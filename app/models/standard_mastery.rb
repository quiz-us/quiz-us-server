# frozen_string_literal: true

# == Schema Information
#
# Table name: standard_masteries
#
#  id           :bigint           not null, primary key
#  num_attempts :integer          default(0), not null
#  num_correct  :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  standard_id  :bigint           not null, indexed, indexed => [student_id]
#  student_id   :bigint           not null, indexed, indexed => [standard_id]
#

class StandardMastery < ApplicationRecord
  belongs_to :student
  belongs_to :standard

  validates :student_id, uniqueness: { scope: %i[standard_id] }
  validates :student, :standard, :num_correct, :num_attempts, presence: true

  def percent_correct
    percentage = (num_correct.to_f / num_attempts) * 100
    percentage.round
  end
end
