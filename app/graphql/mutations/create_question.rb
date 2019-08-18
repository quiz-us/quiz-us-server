
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
    argument :question_options, [String], required: false

    # return type from the mutation
    type Types::QuestionType

    def resolve(question_node: , question_type:, tags:, standard_id:, question_plaintext:, question_options: )
      CreateQuestionService.call({ 
        question_node: question_node,
        question_type: question_type,
        tags: tags,
        standard_id: standard_id,
        question_plaintext: question_plaintext,
        question_options: question_options
      })
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
    
    
#     """
#   	questionType: "mc"
#   	tags: ["sci", "art"]
#   	questionPlaintext: "asdf"
#   	standardId: 1,
#   	questionOptions: ["""{
#   		"correct": "true",
#   		"optionNode": "{}",
#   		"optionText": "correct answer"
# }""", 
#   """{
#   		"correct": "false",
#   		"optionNode": "{}",
#   		"optionText": "not correct answer"
# }"""
# ]
# ) {
#     id
#   	tags {
#       id
#       name
#     }
#   questionText
#   } 
# }