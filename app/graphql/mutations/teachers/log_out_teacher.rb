# frozen_string_literal: true

module Mutations
  module Teachers
    class LogOutTeacher < TeacherMutation
      graphql_name 'Log out teacher'
      description 'Logs teacher out'
      type Boolean

      def resolve
        current_teacher.update(jti: SecureRandom.hex(8))
      end
    end
  end
end
