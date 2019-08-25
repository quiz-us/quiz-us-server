# frozen_string_literal: true

module Queries
  module Students
    class DeckIndex < BaseQuery
      description 'Display all decks for current student'

      type [Types::AssignmentType], null: false

      def resolve
        current_student.assignments
      end
    end
  end
end
