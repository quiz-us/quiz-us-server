module Queries
  class QuestionShow < BaseQuery
    description 'Display one question'

    argument :id, ID, required: true
    
    type Types::QuestionType, null: false

    def resolve(id: )
      Question.find(id)
    end
  end
end

# sample query
# {
#   question(id: 1) {
#     id,
#     questionNode

#   } 
# }
