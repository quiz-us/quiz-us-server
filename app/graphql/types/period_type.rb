# frozen_string_literal: true

module Types
  class PeriodType < BaseObject
    description 'Deck'
    field :id, ID, null: false
    field :name, String, null: false
  end
end
