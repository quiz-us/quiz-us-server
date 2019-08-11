# frozen_string_literal: true

# query resolvers

module Types
  class QueryType < BaseObject
    # queries are just represented as fields
    field :standards_charts, resolver: Queries::StandardsChartIndex

    # sample query @ url "/graphiql"
    # query {
    #   standardsCharts {
    #     title
    #   }
    # }
  end
end
