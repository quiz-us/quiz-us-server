# frozen_string_literal: true

module Assignments
  # Service finds the current question that a student is on for an assignment
  class FindCurrentQuestion
    include Callable

    attr_reader :assignment_id, :student_id

    def initialize(student_id, assignment_id)
      @student_id = student_id
      @assignment_id = assignment_id
    end

    def call
      id = current_question_id

      Question.find(id)
    rescue ActiveRecord::RecordNotFound
      nil
    end

    private

    def current_question_id
      all_questions = Assignment.find(assignment_id).deck.questions.pluck(:id)
      responses = all_responses
      unanswered = all_questions - responses.keys

      return unanswered.first unless unanswered.empty?

      incorrect_responses = responses.reject { |_, v| v[:correct] }
      sorted_responses = incorrect_responses.sort_by { |_, v| v[:timestamp] }

      return sorted_responses[0][0] unless sorted_responses.empty?

      nil
    end

    def all_responses
      all_responses = {}
      Response.where(
        assignment_id: assignment_id,
        student_id: student_id
      ).order(updated_at: :asc).each do |response|
        question_id = response.question_id
        # Once a response has been toggled to correct, leave it alone:
        if all_responses[question_id] && all_responses[question_id][:correct]
          next
        end

        all_responses[question_id] = {
          correct: response.correct,
          timestamp: response.updated_at
        }
      end

      all_responses
    end
  end
end
