# frozen_string_literal: true

module Queries
  module Shared
    class SharedQuery < BaseQuery
      def ready?(**_args)
        teacher_or_student_signed_in?
      end
    end
  end
end
