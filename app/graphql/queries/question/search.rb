# frozen_string_literal: true

require 'search_object'

module Queries
  module Question
    class Search < BaseQuery
      # https://github.com/rstankov/SearchObjectGraphQL:
      include SearchObject.module(:graphql)

      description 'Search for questions'

      type [Types::QuestionType], null: false

      scope { current_course.questions }

      option(:standard_id, type: ID) do |scope, value|
        scope.joins(:questions_standards)
             .where(questions_standards: { standard_id: value })
      end
    end
  end
end
