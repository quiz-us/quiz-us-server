# frozen_string_literal: true

module Queries
  module Teachers
    class QuestionShow < TeacherQuery
      description 'Display one question'

      argument :id, ID, required: true

      type Types::QuestionType, null: false

      def resolve(id:)
        Question.includes(:taggings, :tags).find(id)
      end
    end
  end
end
