# frozen_string_literal: true

module Mutations
  module Teachers
    class TeacherMutation < BaseMutation
      def ready?(**_args)
        teacher_signed_in?
      end
    end
  end
end
