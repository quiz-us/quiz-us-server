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

  def current_question(student_id)
    # deck.questions sort by number of responses to that question in this assignment
    # and sort by id just to really ensure that questions are not switching back and forth
    # between refreshes.

    # https://stackoverflow.com/a/42847464
    # deck.questions
    #     .left_joins(:responses)
    #     .group(:id)
    #     .order('COUNT(responses.id) ASC')
    # actually, I can just grab a list of all responses to this assignment,
    # diff its question.id against
    # just pseudocode because current_student does not exist here:
    questions_with_response_ids = {}
    deck.questions.each do |question|
      questions_with_response_ids[question.id] = 0
    end
    responses.where(student_id: student_id).each do |response|
      questions_with_response_ids[response.question.id] += 1
    end

    questions_with_response_ids
    # at this point, send back the question with the lowest amount of responses
    # but also sort by id to lock in the same question every time?

    # one thing I'm not thinking through: once a question has been answered correctly,
    # it should not be seen again in that assignment.
    # current test code in rails console: Assignment.second.current_question(student_id)
  end
end
