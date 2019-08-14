module Types
  class StandardType < BaseObject
    description "Standard Description"
    field :id, ID, null: false
    field :text, String, null: false
    field :questions, [Types::QuestionType], null: true
  end
end


# {
#   standard(id: 1) {
#     id,
#     text,
#     questions {
#       id,
#       questionText
#     }
#   } 
# }