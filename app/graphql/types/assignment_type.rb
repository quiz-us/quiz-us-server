# frozen_string_literal: true

module Types
  class AssignmentType < BaseObject
    description 'Assignment'
    field :id, ID, null: false
    field :deck, Types::DeckType, null: false
    field :period, Types::PeriodType, null: false
  end
end
