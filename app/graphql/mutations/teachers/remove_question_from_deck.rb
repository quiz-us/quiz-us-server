# frozen_string_literal: true

module Mutations
  module Teachers
    class RemoveQuestionFromDeck < TeacherMutation
      graphql_name 'Remove a question from a deck'
      description 'Remove a question from a deck'

      argument :deck_id, ID, required: true
      argument :question_id, ID, required: true

      type Types::DecksQuestionType

      def resolve(deck_id:, question_id:)
        card = DecksQuestion.find_by!(deck_id: deck_id, question_id: question_id)
        card.destroy!
        card
      end
    end
  end
end
