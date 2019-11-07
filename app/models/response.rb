# frozen_string_literal: true

# == Schema Information
#
# Table name: responses
#
#  id                 :integer          not null, primary key
#  mc_correct         :boolean
#  response_text      :text
#  self_grade         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  assignment_id      :integer
#  question_id        :integer          not null
#  question_option_id :integer          indexed
#  student_id         :integer          not null, indexed
#

class Response < ApplicationRecord
  validates :student, :question, presence: true
  belongs_to :student
  belongs_to :question
  belongs_to :question_option, optional: true
  belongs_to :assignment, optional: true
end
