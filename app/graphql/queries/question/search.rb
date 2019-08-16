# frozen_string_literal: true

require 'search_object'

module Queries
  module Question
    class Search < BaseQuery
      include SearchObject.module(:graphql)

      description 'Search for questions'

      type [Types::QuestionType], null: false

      scope { current_course.questions }

      option(:standardId, type: ID) do |scope, value|
        scope.joins(:questions_standards)
             .where(questions_standards: { standard_id: value })
      end
    end
  end
end
