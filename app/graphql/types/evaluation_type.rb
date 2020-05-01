# frozen_string_literal: true

module Types
  class EvaluationType < BaseObject
    description 'Result of comparing solution with submitted text'
    field :percent, Float, null: false
  end
end
