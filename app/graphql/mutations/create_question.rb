
module Mutations
  class CreateQuestion < BaseMutation
    graphql_name 'Create Question'
    description "Create Question"

    # arguments passed to the `resolved` method
    argument :question_type, String, required: true
    argument :standard_id, ID, required: false
    argument :tags, [String], required: false
    argument :question_node, String, required: true

    # return type from the mutation
    type Types::QuestionType

    def resolve(question_node: , question_type:, tags:, standard_id: )
      question = CreateQuestionService.call({ 
        question: {
          question_node: question_node,
          question_type: question_type,
          tags: tags,
          standard_id: standard_id
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



