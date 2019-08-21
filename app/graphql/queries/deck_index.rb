# frozen_string_literal: true

module Queries
  class DeckIndex < BaseQuery
    description 'Display all decks'

    type [Types::DeckType], null: false

    def resolve
      current_teacher.decks.order(updated_at: :desc)
    end
  end
end
