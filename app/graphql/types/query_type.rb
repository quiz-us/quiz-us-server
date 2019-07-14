# query resolvers

module Types
  class QueryType < BaseObject
    # queries are just represented as fields
    field :standards_charts_index, [StandardsChartType], null: false

    # field name and method name must match
    # query names change from snake case to camelCase
    # ex: standards_charts_index => 
    def standards_charts_index
      StandardsChart.all
    end

    # sample query @ url "/graphiql"
    # query {
    #   allStandardsCharts {
    #     title
    #   }
    # }
  end
end