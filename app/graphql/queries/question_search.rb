# frozen_string_literal: true

require 'search_object'
require 'search_object/plugin/graphql'

module Queries
  class QuestionSearch < BaseQuery
    # https://github.com/rstankov/SearchObjectGraphQL:
    include SearchObject.module(:graphql)

    description 'Search for questions'

    type [Types::QuestionType], null: false

    scope { current_course.questions }

    option(:standard_id, type: ID) do |scope, value|
      if value.empty?
        scope
      else
        scope.joins(:questions_standards)
             .where(questions_standards: { standard_id: value })
      end
    end

    option(:key_words, type: String) do |scope, value|
      if value.empty?
        scope
      else
        scope.search_for(value)
      end
    end
  end
end
