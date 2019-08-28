# frozen_string_literal: true

module Types
  class QuestionType < BaseObject
    description 'Question Description'
    field :id, ID, null: false
    field :question_text, String, null: false
    field :question_type, String, null: false
    field :rich_text, String, null: false
    field :standards, [Types::StandardType], null: true
    field :tags, [Types::TagType], null: true
    field :taggings, [Types::TaggingType], null: true
    field :question_options, [Types::QuestionOptionType], null: true
    # TODO: investigate if we can delete this field. It isnt being used in the create question form
    # field :question_plaintext, String, null: true
  end
end
