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

    option(:empty_query, type: Boolean) do |scope, value|
      # return empty object if all other query parameters
      # are empty
      scope.none if value
    end

    option(:standard_id, type: ID) do |scope, value|
      unless value.empty?
        scope.joins(:questions_standards)
             .where(questions_standards: { standard_id: value })
      end
    end

    option(:key_words, type: String) do |scope, value|
      scope.search_for(value) unless value.empty?
    end
  end
end
