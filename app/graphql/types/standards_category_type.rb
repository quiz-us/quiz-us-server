# frozen_string_literal: true

module Types
  class StandardsCategoryType < BaseObject
    description 'Standards Category'
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: true
  end
end
