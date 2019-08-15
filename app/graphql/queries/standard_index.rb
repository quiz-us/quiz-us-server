# frozen_string_literal: true

module Queries
  class StandardIndex < BaseQuery
    description 'Display all standards'

    type [Types::StandardType], null: false

    def resolve
      Standard.all
    end
  end
end
