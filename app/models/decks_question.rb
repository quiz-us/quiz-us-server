# frozen_string_literal: true

# == Schema Information
#
# Table name: decks_questions
#
#  deck_id                 :integer          not null
#  question_id             :integer          not null
#  id                      :bigint           not null, primary key
#  num_consecutive_correct :integer
#  total_correct           :integer
#  total_attempts          :integer
#  e_factor                :float
#  next_due                :datetime
#

class DecksQuestion < ApplicationRecord
  belongs_to :deck
  belongs_to :question
  validates :question_id, uniqueness: { scope: :deck_id }
end
