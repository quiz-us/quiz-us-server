# frozen_string_literal: true

module Types
  class ResponseType < BaseObject
    description 'Response'
    field :id, ID, null: false
    field :question_id, ID, null: false
  end
end
