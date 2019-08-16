# frozen_string_literal: true

require 'active_support/concern'

module Authenticable
  extend ActiveSupport::Concern

  included do
    def teacher_signed_in?
      raise GraphQL::ExecutionError, 'Unauthenticated' unless current_teacher
    end

    def current_teacher
      context[:current_teacher]
    end
  end
end
