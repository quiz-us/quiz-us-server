# frozen_string_literal: true

module Types
  class StandardsMasteryType < BaseObject
    description 'standards mastery'
    field :num_attempted, Integer, null: false
    field :num_correct, Integer, null: false
    field :standard, Types::StandardType, null: false
  end
end
