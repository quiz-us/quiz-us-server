# frozen_string_literal: true

# == Schema Information
#
# Table name: decks_questions
#
#  id                      :bigint           not null, primary key
#  deck_id                 :integer          not null
#  question_id             :integer          not null
#  num_consecutive_correct :integer          default(0)
#  total_correct           :integer          default(0)
#  total_attempts          :integer          default(0)
#  e_factor                :float            default(2.5)
#  next_due                :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class DecksQuestion < ApplicationRecord
  validates :question_id, uniqueness: { scope: :deck_id }

  belongs_to :deck
  belongs_to :question
  delegate :responses, to: :question

  # self.join(:responses).order(due: :asc)
end
