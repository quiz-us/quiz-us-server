# frozen_string_literal: true

module Mutations
  class CreateQuestion < BaseMutation
    graphql_name 'Create Question'
    description 'Create Question'

    # arguments passed to the `resolved` method
    argument :question_type, String, required: true
    argument :standard_id, ID, required: false
    argument :tags, [String], required: false
    argument :rich_text, String, required: true
    argument :question_plaintext, String, required: true
    argument :question_options, [String], required: false

    # return type from the mutation
    type Types::QuestionType

    def resolve(rich_text:, question_type:, tags:, standard_id:, question_plaintext:, question_options:)
      CreateQuestionService.call(
        rich_text: rich_text,
        question_type: question_type,
        tags: tags,
        standard_id: standard_id,
        question_plaintext: question_plaintext,
        question_options: question_options
      )
    end
  end
end


# sample mutation
# mutation {
#   createQuestion(
#     richText: "{
#       \"object\":\"value\",
#       \"document\":{
#         \"object\":\"document\",
#         \"data\":{},
#         \"nodes\":[{
#           \"object\":\"block\",
#           \"type\":\"line\",
#           \"data\":{},
#           \"nodes\":[{\"object\":\"text\",\"text\":\"test\",\"marks\":[]}]
#         }]
#       }
#     }"
#   	questionType: "mc"
#   	tags: ["sci", "art"]
#   	questionPlaintext: "asdf"
#   	standardId: 1,
#   	questionOptions: ["""{
#   		"isCorrect": true,
#   		"value": "{}",
#   		"answerText": "correct answer"
# }""", 
#   """{
#   		"isCorrect": false,
#   		"value": "{}",
#   		"answerText": "not correct answer"
# }"""
# ]
# ) {
#     id
#   	tags {
#       id
#       name
#     }
#   questionText
#   questionOptions {
#     id
#     optionText
#   }
#   } 
# }