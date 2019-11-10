# frozen_string_literal: true

module Queries
  module Students
    class CurrentStudent < StudentQuery
      graphql_name 'Current Student'
      description 'Return current student'

      type Types::StudentType, null: false

      def resolve
        current_student
      end
    end
  end
end
