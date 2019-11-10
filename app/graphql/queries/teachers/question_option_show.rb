# frozen_string_literal: true

module Queries
  module Teachers
    class QuestionOptionShow < TeacherQuery
      description 'Display one question option'

      argument :id, ID, required: true

      type Types::QuestionOptionType, null: false

      def resolve(id:)
        QuestionOption.find(id)
      end
    end
  end
end
