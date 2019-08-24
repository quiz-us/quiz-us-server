# frozen_string_literal: true

# query resolvers

module Types
  class QueryType < BaseObject
    field :deck, resolver: Queries::DeckShow
    field :decks, resolver: Queries::DeckIndex
    field :standards_charts, resolver: Queries::StandardsChartIndex
    field :question, resolver: Queries::QuestionShow
    field :questions, resolver: Queries::QuestionSearch
    field :tag, resolver: Queries::TagShow
    field :tagging, resolver: Queries::TaggingShow
    field :standard, resolver: Queries::StandardShow
    field :all_standards, resolver: Queries::StandardIndex
    field :question_option, resolver: Queries::QuestionOptionShow
    field :tags, resolver: Queries::TagIndex
    field :tag_search, resolver: Queries::TagSearch
  end
end
