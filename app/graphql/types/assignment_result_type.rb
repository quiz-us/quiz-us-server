# frozen_string_literal: true

module Types
  class AssignmentResultType < BaseObject
    description 'Assignment Result'
    field :fullname, String, null: false
    field :answer, String, null: false
  end
end
