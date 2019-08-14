module Queries
  class QuestionOptionShow < BaseQuery
    description 'Display one question option'

    argument :id, ID, required: true
    
    type Types::QuestionOptionType, null: false

    def resolve(id: )
      QuestionOption.find(id)
    end
  end
end

# query {
#   questionOption(id: 1) {
#     id
#     questionId
#     correct
#     question {
#       id
#     }
#   }
# }