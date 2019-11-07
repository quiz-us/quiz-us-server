# frozen_string_literal: true

# == Schema Information
#
# Table name: assignments
#
#  id           :bigint           not null, primary key
#  due          :datetime         indexed
#  instructions :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  deck_id      :bigint           not null, indexed
#  period_id    :bigint           not null, indexed
#


class Assignment < ApplicationRecord
  belongs_to :period
  belongs_to :deck

  has_many :responses, -> { order(:created_at) },
           dependent: :destroy,
           inverse_of: :assignment

  validates :deck, :period, presence: true

  def num_correct_responses(student_id)
    responses.where(student_id: student_id)
             .where(
               'mc_correct = ? OR self_grade >= ?',
               true,
               4
             ).length
  end

  def num_questions
    deck.questions.length
  end
end
