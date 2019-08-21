# frozen_string_literal: true

module Queries
  class DeckShow < BaseQuery
    graphql_name 'Deck show'
    description 'Return a deck'

    argument :id, ID, required: true

    type Types::DeckType, null: false

    def resolve(id:)
      current_teacher.decks.find(id)
    end
  end
end
