# frozen_string_literal: true

module Mutations
  class UpdateQuestion < BaseMutation
    graphql_name 'Edit Question'
    description 'Edit Question'

    # arguments passed to the `resolved` method
    argument :id, ID, required: true
    argument :question_type, String, required: false
    argument :standard_id, ID, required: false
    argument :tags, [String], required: false
    argument :rich_text, String, required: false
    argument :question_plaintext, String, required: false
    argument :question_options, [String], required: false

    # return type from the mutation
    type Types::QuestionType

    def resolve(
      id:, 
      question_type: nil, 
      rich_text: nil, 
      question_plaintext: nil, 
      standard_id: nil, 
      tags: nil
      # question_options: nil
      )
      question = Question.find(id)
      question.question_type = question_type if question_type
      question.rich_text = rich_text if rich_text
      question.question_text = question_plaintext if question_plaintext
      question.save!

      question.standards = [Standard.find(standard_id)] if standard_id
      question.tags = tags.map{ |tag| Tag.find_or_create_by(name: tag) } if tags
      # question.question_options = question_options if question_options
      question
    end
  end
end