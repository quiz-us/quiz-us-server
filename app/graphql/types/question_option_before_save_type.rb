module Types
  class QuestionOptionBeforeSaveType < BaseObject
    description "Question Option Before Save Description"
    
    description "Question Option Description"
    # field :id, ID, null: true
    # field :question_id, ID, null: true
    field :option_text, String, null: false
    field :rich_text, String, null: false
    field :correct, Boolean, null: false

  end
end