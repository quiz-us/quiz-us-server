# frozen_string_literal: true

module Types
  class AssignmentType < BaseObject
    description 'Assignment'
    field :id, ID, null: true
    field :instructions, String, null: true
    field :deck, Types::DeckType, null: false
    field :due, Types::DateTimeType, null: true
    field :period, Types::PeriodType, null: false
    field :responses, [Types::ResponseType], null: true
  end
end
