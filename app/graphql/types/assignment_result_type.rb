# frozen_string_literal: true

module Types
  class AssignmentResultType < BaseObject
    description 'Assignment Result'
    field :firstname, String, null: false
    field :lastname, String, null: false
    field :student_id, ID, null: false
    field :result, String, null: false
  end
end
