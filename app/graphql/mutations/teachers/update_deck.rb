# frozen_string_literal: true

module Mutations
  module Teachers
    class UpdateDeck < TeacherMutation
      graphql_name 'Update Deck'
      description 'Update Deck'

      # arguments passed to the `resolved` method
      argument :deck_id, ID, required: true
      argument :question_ids, [ID], required: true
      argument :name, String, required: true
      argument :description, String, required: false

      # return type from the mutation
      type Types::DeckType

      def resolve(deck_id:, question_ids:, name:, description:)
        deck = current_teacher.decks.find(deck_id)
        deck.update!(name: name, description: description)

        # diff the deck's current question_ids with the newly passed in
        # question_ids. Destroy the joins that are not in the new question_ids
        # create the ones that don't exist yet but are in the new question_ids
        existing_questions = deck.cards.pluck(:question_id)
        destroy_questions = existing_questions - question_ids
        add_questions = question_ids - existing_questions

        destroy_questions.each do |question_id|
          deck.cards.find_by(question_id: question_id).destroy
        end
        add_questions.each do |question_id|
          deck.cards.create!(question_id: question_id)
        end

        deck
      end
    end
  end
end
