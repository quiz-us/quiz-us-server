# frozen_string_literal: true

module Types
  class ResponseType < BaseObject
    description 'Response'
    field :id, ID, null: false
    field :question_id, ID, null: false
    field :assignment_id, ID, null: true
    field :question_option_id, ID, null: true
    field :response_text, String, null: true
  end
end
