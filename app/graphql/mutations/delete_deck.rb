# frozen_string_literal: true

module Mutations
  class DeleteDeck < BaseMutation
    graphql_name 'Delete Deck'
    description 'Delete Deck'

    # arguments passed to the `resolved` method
    argument :deck_id, ID, required: true

    # return type from the mutation
    type Types::DeckType

    def resolve(deck_id:)
      deck = current_teacher.decks.find(deck_id)
      deck.destroy

      deck
    end
  end
end
