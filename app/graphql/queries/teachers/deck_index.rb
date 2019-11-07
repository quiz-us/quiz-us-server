# frozen_string_literal: true

module Queries
  module Teachers
    class DeckIndex < TeacherQuery
      description 'Display all decks that belong to the current teacher'

      type [Types::DeckType], null: false

      def resolve
        current_teacher.decks.order(updated_at: :desc)
      end
    end
  end
end
