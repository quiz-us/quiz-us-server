# frozen_string_literal: true

module Queries
  module Teachers
    class QuestionSearch < BaseQuery
      description 'Search for questions'

      argument :standard_id, ID, required: false
      argument :key_words, String, required: false

      type [Types::QuestionType], null: false

      def resolve(filters = {})
        scope = Question.none
        filters.each do |_, v|
          if v.present?
            scope = Question.all
            break
          end
        end

        Questions::SearchQuestions.new(scope: scope, filters: filters).results
      end
    end
  end
end
