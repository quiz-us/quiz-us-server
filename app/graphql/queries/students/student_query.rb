# frozen_string_literal: true

module Queries
  module Students
    class StudentQuery < BaseQuery
      def ready?(**_args)
        student_signed_in?
      end
    end
  end
end
