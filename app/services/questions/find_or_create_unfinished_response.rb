# frozen_string_literal: true

module Questions
  # Service finds the current question that a student is on for an assignment
  class FindOrCreateUnfinishedResponse
    include Callable

    attr_reader :response_params

    def initialize(question_id, student_id, assignment_id)
      @response_params = {
        question_id: question_id,
        student_id: student_id,
        assignment_id: assignment_id
      }
    end

    def call
      return nil if response_params[:question_id].nil?

      responses = Response.where(response_params)

      responses.find(&:unfinished) || Response.create!(response_params)
    end
  end
end
