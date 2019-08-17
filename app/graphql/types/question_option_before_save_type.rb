module Types
  class QuestionOptionBeforeSaveType < BaseObject
    description "Question Option Before Save Description"
    
    description "Question Option Description"
    # field :id, ID, null: true
    # field :question_id, ID, null: true
    field :option_text, String, null: false
    field :option_node, String, null: false
    field :correct, Boolean, null: false

  end
end