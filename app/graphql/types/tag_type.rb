module Types
  class TagType < BaseObject
    description "Tag Description"
    field :id, ID, null: false
    field :name, String, null: false
  end
end
