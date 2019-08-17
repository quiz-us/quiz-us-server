module Queries
  class QuestionOptionBeforeSaveShow < BaseQuery
    description 'Display one question option before save'
    argument :id, ID, required: true

    type Types::QuestionOptionBeforeSaveType, null: false

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