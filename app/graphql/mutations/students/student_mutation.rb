# frozen_string_literal: true

module Mutations
  module Students
    class StudentMutation < BaseMutation
      def ready?(**_args)
        teacher_signed_in?
      end
    end
  end
end
