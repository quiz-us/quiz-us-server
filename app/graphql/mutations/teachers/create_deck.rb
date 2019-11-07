# frozen_string_literal: true

module Mutations
  module Teachers
    class CreateDeck < TeacherMutation
      graphql_name 'Create Deck'
      description 'Create Deck'

      # arguments passed to the `resolved` method
      argument :question_ids, [ID], required: true
      argument :name, String, required: true
      argument :description, String, required: false

      # return type from the mutation
      type Types::DeckType

      def resolve(question_ids:, name:, description:)
        deck = current_teacher.decks.create!(
          name: name,
          description: description
        )
        question_ids.each do |question_id|
          deck.cards.create!(question_id: question_id)
        end
        deck
      end
    end
  end
end
