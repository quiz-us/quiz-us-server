# frozen_string_literal: true

module Types
  class StandardMasteryType < BaseObject
    description 'Standard Description'
    field :id, ID, null: true
    field :num_attempts, Integer, null: true
    field :num_correct, Integer, null: true
    field :percent_correct, Integer, null: true
    field :standard, Types::StandardType, null: true
  end
end
