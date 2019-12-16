# frozen_string_literal: true

module Mutations
  module Students
    class StudentMutation < BaseMutation
      # https://github.com/rmosolgo/graphql-ruby/blob/master/guides/mutations/mutation_authorization.md#checking-the-user-permissions
      def ready?(**_args)
        student_signed_in?
      end
    end
  end
end
