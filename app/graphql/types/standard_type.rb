# frozen_string_literal: true

module Types
  class StandardType < BaseObject
    description 'Standard Description'
    field :id, ID, null: false
    field :description, String, null: false
    field :title, String, null: false
    field :questions, [Types::QuestionType], null: true
    field :standardsCategory, Types::StandardsCategoryType, null: true
  end
end

# {
#   standard(id: 1) {
#     id,
#     title,
#     description,
#     questions {
#       id,
#       questionText
#     }
#   }
# }
