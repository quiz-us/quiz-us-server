# frozen_string_literal: true

module Types
  class TeacherType < BaseObject
    field :id, ID, null: false
    field :email, String, null: true
    field :token, String, null: false
    field :onboarded, Boolean, null: false
  end
end
