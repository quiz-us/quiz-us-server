# frozen_string_literal: true

# == Schema Information
#
# Table name: assignments
#
#  id           :bigint           not null, primary key
#  deck_id      :bigint           not null
#  due          :datetime
#  instructions :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  period_id    :bigint           not null
#

class Assignment < ApplicationRecord
  belongs_to :period
  belongs_to :deck

  has_many :responses, -> { order(:created_at) }, dependent: :destroy

  def num_correct_responses
    responses.where('mc_correct = ? OR self_grade >= ?', true, 4).length
  end

  def num_questions
    deck.questions.length
  end
end
