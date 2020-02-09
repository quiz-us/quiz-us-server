# frozen_string_literal: true

module Assignments
  # Service finds the current question that a student is on for an assignment
  class FindCurrentQuestion
    include Callable

    attr_reader :assignment_id, :student_id

    def initialize(student_id:, assignment_id:)
      @student_id = student_id
      @assignment_id = assignment_id
    end

    def call
      id = current_question_id

      id ? Question.find(id) : nil
    end

    private

    def current_question_id
      all_questions = Assignment.find(assignment_id).deck.questions.pluck(:id)
      responses = all_responses
      unanswered = all_questions - responses.keys

      return unanswered.first unless unanswered.empty?

      responses.key(false)
    end

    def all_responses
      all_responses = {}
      Response.find_by(
        assignment_id: assignment_id,
        student_id: student_id
      ).includes(:question_option).each do |response|
        question_id = response.question_option.question_id
        # Once a response has been toggled to correct, leave it alone:
        unless all_responses[question_id]
          all_responses[question_id] = response.correct
        end
      end

      all_responses
    end
  end
end
