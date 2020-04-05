# frozen_string_literal: true

module Queries
  module Teachers
    class TeacherShow < TeacherQuery
      graphql_name 'Teacher show'
      description 'Return current_teacher'

      type Types::TeacherType, null: false

      def resolve
        current_teacher
      end
    end
  end
end
