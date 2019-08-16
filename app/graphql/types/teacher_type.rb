module Types
  class TeacherType < BaseObject
    field :id, ID, null: false
    field :email, String, null: true
    field :token, String, null: false
  end
end
