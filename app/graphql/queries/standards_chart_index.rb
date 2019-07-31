module Queries
  class StandardsChartIndex < BaseQuery
    description 'Find all the Standards Chart'

    type [Types::StandardsChartType], null: false


    def resolve
      StandardsChart.all
    end
  end
end

# sample query
# {
#   standardsCharts {
#     id
#     title
#   } 
# }
