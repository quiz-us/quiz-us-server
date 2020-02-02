# frozen_string_literal: true

module Mutations
  module Teachers
    class AddQuestionToDeck < TeacherMutation
      graphql_name 'Add a card to a deck'
      description 'Add a card to a deck'

      argument :deck_id, ID, required: true
      argument :question_id, ID, required: true

      type Types::DecksQuestionType

      def resolve(deck_id:, question_id:)
        card = DecksQuestion.create!(deck_id: deck_id, question_id: question_id)

        card
      end
    end
  end
end
