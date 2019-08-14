module Types
  class QuestionType < BaseObject
    description "Question Description"
    field :id, ID, null: false
    field :question_text, String, null: false
    field :question_type, String, null: false
    field :question_node, String, null: false
    field :tags, [Types::TagType], null: true
    field :taggings, [Types::TaggingType], null: true
  end
end
