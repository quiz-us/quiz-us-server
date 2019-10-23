# frozen_string_literal: true

module Queries
  module Teachers
    class TeacherQuery < BaseQuery
      def ready?(**_args)
        teacher_signed_in?
      end
    end
  end
end
