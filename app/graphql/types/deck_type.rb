# frozen_string_literal: true

module Types
  class DeckType < BaseObject
    description 'Deck'
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :cards, [Types::DecksQuestionType], null: true
    field :questions, [Types::QuestionType], null: true
  end
end
