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
      unfinished = all_responses.unfinished.first
      return unfinished.question.id if unfinished

      all_questions = Assignment.find(assignment_id).deck.questions
                                .order(created_at: :asc).pluck(:id)
      responses = responses_by_question_id
      unanswered = all_questions - responses.keys
      return unanswered.first unless unanswered.empty?

      incorrect_responses = responses.reject { |_, v| v[:correct] }
      sorted_responses = incorrect_responses.sort_by { |_, v| v[:timestamp] }
      return sorted_responses[0][0] unless sorted_responses.empty?

      nil
    end

    def responses_by_question_id
      responses_by_question = {}

      all_responses.each do |response|
        question_id = response.question_id
        # Once a response has been toggled to correct, leave it alone:
        if responses_by_question[question_id] &&
           responses_by_question[question_id][:correct]
          next
        end

        responses_by_question[question_id] = {
          correct: response.correct,
          timestamp: response.created_at
        }
      end

      responses_by_question
    end

    def all_responses
      @all_responses ||= Response.where(
        assignment_id: assignment_id,
        student_id: student_id
      ).order(created_at: :asc)
    end
  end
end
