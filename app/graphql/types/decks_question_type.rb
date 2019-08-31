# frozen_string_literal: true

module Types
  class DecksQuestionType < BaseObject
    description 'represents decks_questions table and is essentially a card in a deck'
    field :id, ID, null: false
    field :next_due, Types::DateTimeType, null: true
    field :question, Types::QuestionType, null: false
  end
end
