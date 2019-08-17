
module Mutations
  class CreateQuestion < BaseMutation
    graphql_name 'Create Question'
    description "Create Question"

    # arguments passed to the `resolved` method
    argument :question_type, String, required: true
    argument :standard_id, ID, required: false
    argument :tags, [String], required: false
    argument :question_node, String, required: true
    argument :question_plaintext, String, required: true
    # argument :answers, [Types::QuestionOptionType], required: false
    # argument :tags_test, [Types::TagType], required: false
    field :answers, [Types::QuestionOptionType], null: false do
      argument :attributes, Types::QuestionOptionType, required: true
    end

    # return type from the mutation
    type Types::QuestionType

    def resolve(question_node: , question_type:, tags:, standard_id:, question_plaintext: )
      question = CreateQuestionService.call({ 
        question: {
          question_node: question_node,
          question_type: question_type,
          tags: tags,
          standard_id: standard_id,
          question_plaintext: question_plaintext
          # answers: answers
        }
      })
      question[:question]
    end
  end
end

# sample mutation

# mutation {
#   createQuestion(questionNode: """
#     {      
#         "object": "block",
#         "type": "paragraph",
#         "nodes": [
#           {
#             "object": "text",
#             "text": "A line of text in a paragraph."
#           }
#         ]
# 		}
    
    
#     """, 
#   	questionType: "mc",
#   	questionTags: "sci, art"
# ) {
#     id
#   	tags {
#       id
#       name
#     }
#   questionText
#   } 
# }



