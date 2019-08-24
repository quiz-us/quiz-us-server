# frozen_string_literal: true

module Queries
  module Students
    class CurrentStudent < BaseQuery
      graphql_name 'Current Student'
      description 'Return current student'

      type Types::StudentType, null: false

      def resolve
        raise GraphQL::ExecutionError, 'Unauthenticated' unless context[:current_student]

        context[:current_student]
      end
    end
  end
end
