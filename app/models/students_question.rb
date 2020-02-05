# frozen_string_literal: true

# == Schema Information
#
# Table name: students_questions
#
#  id                      :bigint           not null, primary key
#  e_factor                :float            default(2.5), not null
#  next_due                :datetime         not null, indexed
#  num_consecutive_correct :integer          default(0), not null
#  total_attempts          :integer          default(0), not null
#  total_correct           :integer          default(0), not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  question_id             :bigint           not null, indexed
#  student_id              :bigint           not null, indexed
#
# StudentsQuestion tracks a student's performance on a question
class StudentsQuestion < ApplicationRecord
  belongs_to :student
  belongs_to :question

  validates :student, :question, :e_factor, :next_due,
            :num_consecutive_correct, :total_attempts, :total_correct,
            presence: true
end
