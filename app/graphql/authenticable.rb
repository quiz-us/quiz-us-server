# frozen_string_literal: true

require 'active_support/concern'

module Authenticable
  extend ActiveSupport::Concern

  included do
    def teacher_signed_in?
      raise GraphQL::ExecutionError, 'Unauthenticated' unless current_teacher

      true
    end

    def student_signed_in?
      raise GraphQL::ExecutionError, 'Unauthenticated' unless current_student

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
  end
end
