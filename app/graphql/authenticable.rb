# frozen_string_literal: true

require 'active_support/concern'

module GraphQL::Authenticable
  extend ActiveSupport::Concern

  included do
    def teacher_signed_in?
      teacher = context[:current_teacher]
      raise GraphQL::ExecutionError, 'Unauthenticated' unless teacher
    end
  end
end
