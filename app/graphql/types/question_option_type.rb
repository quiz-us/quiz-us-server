module Types
  class QuestionOptionType < BaseObject
    # description "Question Option Description"
    field :id, ID, null: false
    field :question_id, ID, null: false
    field :option_text, String, null: false
    field :correct, Boolean, null: false
    field :question, Types::QuestionType, null: true
  end
end