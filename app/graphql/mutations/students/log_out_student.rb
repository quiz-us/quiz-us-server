# frozen_string_literal: true

module Mutations
  module Students
    class LogOutStudent < StudentMutation
      graphql_name 'Log out student'
      description 'Logs student out'
      type Boolean

      def resolve
        current_student.update(jti: SecureRandom.hex(8))
      end
    end
  end
end
