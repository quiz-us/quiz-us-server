module Types
  class TaggingType < BaseObject
    description "Tag Description"
    field :id, ID, null: false
    field :question_id, ID, null: false
    field :tag_id, ID, null: false
  end
end
