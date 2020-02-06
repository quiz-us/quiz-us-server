# frozen_string_literal: true

# == Schema Information
#
# Table name: responses
#
#  id                 :integer          not null, primary key
#  mc_correct         :boolean          indexed
#  response_text      :text
#  self_grade         :integer          indexed
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  assignment_id      :integer
#  question_id        :integer          not null
#  question_option_id :integer          indexed
#  student_id         :integer          not null, indexed
#

class Response < ApplicationRecord
  MIN_CORRECT_SCORE = 4

  validates :student, :question, presence: true
  belongs_to :student
  belongs_to :question
  belongs_to :question_option, optional: true
  belongs_to :assignment, optional: true
  has_many :standards, through: :question

  scope :correct, lambda {
    where('mc_correct = ? OR self_grade >= ?', true, MIN_CORRECT_SCORE)
  }

  def correct
    mc_correct || (self_grade.present? && self_grade >= MIN_CORRECT_SCORE)
  end

  def calculate_mastery!(student)
    standards.each do |standard|
      mastery = StandardMastery.find_or_create_by!(
        standard: standard,
        student: student
      )

      num_correct = mastery.num_correct
      num_correct += 1 if correct
      mastery.update!(
        num_attempts: mastery.num_attempts + 1,
        num_correct: num_correct
      )
    end
  end
end
