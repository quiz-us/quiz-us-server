# frozen_string_literal: true

module Types
  class StudentType < BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :token, String, null: false
  end
end
