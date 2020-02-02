# frozen_string_literal: true

module Mutations
  module Teachers
    class CreateDeck < TeacherMutation
      graphql_name 'Create Deck'
      description 'Create Deck'

      argument :name, String, required: true
      argument :description, String, required: false

      # return type from the mutation
      type Types::DeckType

      def resolve(name:, description:)
        deck = current_teacher.decks.create!(
          name: name,
          description: description
        )
        deck
      end
    end
  end
end
