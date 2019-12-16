# frozen_string_literal: true

# == Schema Information
#
# Table name: translations
#
#  id          :bigint           not null, primary key
#  count       :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint           not null, indexed, indexed => [student_id]
#  student_id  :bigint           not null, indexed, indexed => [question_id]
#

class Translation < ApplicationRecord
  belongs_to :student
  belongs_to :question

  validates :student_id, uniqueness: { scope: %i[question_id] }
  validates :student, :question, :count, presence: true
end
