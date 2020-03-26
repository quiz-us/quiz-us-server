# frozen_string_literal: true

require 'active_support/concern'

module Authenticable
  extend ActiveSupport::Concern

  included do
    def teacher_signed_in?
      auth_token
      true
    rescue JWT::VerificationError, JWT::DecodeError
      raise GraphQL::ExecutionError, 'Unauthenticated'
  end

    def student_signed_in?
      raise GraphQL::ExecutionError, 'Unauthenticated' unless current_student

      true
    end

    def teacher_or_student_signed_in?
      unless current_student || current_teacher
        raise GraphQL::ExecutionError, 'Unauthenticated'
      end

      true
    end

    def current_course
      # @todo: in the future, if a teacher has more than one course, we would
      # need to add a course switching interface in the frontend and pass
      # up current_course with each request. For example:
      # current_teacher.courses.find(:id)
      current_teacher.courses.first
    end

    def current_teacher
      context[:current_teacher]
    end

    def current_student
      context[:current_student]
    end

    private

    def http_token
      if request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      end
    end

    def auth_token
      JsonWebToken.verify(http_token)
    end
  end
end
