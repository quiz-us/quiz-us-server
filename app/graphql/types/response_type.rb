# frozen_string_literal: true

module Types
  class ResponseType < BaseObject
    description 'Response'
    field :assignment_id, ID, null: true
    field :created_at, Types::DateTimeType, null: true
    field :id, ID, null: false
    field :mc_correct, Boolean, null: true
    field :question_id, ID, null: false
    field :question_option_id, ID, null: true
    field :question_option, Types::QuestionOptionType, null: true
    field :response_text, String, null: true
    field :self_grade, Integer, null: true
    field :correct_question_option, Types::QuestionOptionType, null: true
  end
end
