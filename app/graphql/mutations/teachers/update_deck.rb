# frozen_string_literal: true

module Mutations
  module Teachers
    class UpdateDeck < TeacherMutation
      graphql_name 'Update Deck'
      description 'Update Deck'

      # arguments passed to the `resolved` method
      argument :deck_id, ID, required: true
      argument :name, String, required: true
      argument :description, String, required: false

      # return type from the mutation
      type Types::DeckType

      def resolve(deck_id:, name:, description:)
        deck = current_teacher.decks.find(deck_id)
        deck.update!(name: name, description: description)

        deck
      end
    end
  end
end
