# frozen_string_literal: true

# query resolvers

module Types
  class QueryType < BaseObject
    # queries are just represented as fields
    field :standards_charts, resolver: Queries::StandardsChartIndex
    field :question, resolver: Queries::QuestionShow
    field :tag, resolver: Queries::TagShow
    field :tagging, resolver: Queries::TaggingShow
    field :standard, resolver: Queries::StandardShow
    field :all_standards, resolver: Queries::StandardIndex
  end
end
