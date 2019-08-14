
module Mutations
  class EditStandardsChart < BaseMutation
    graphql_name 'Edit Standards Chart'
    description "Edit Standards Chart description"

    # arguments passed to the `resolved` method
    argument :id, ID, required: true
    argument :title, String, required: true

    # return type from the mutation
    type Types::StandardsChartType

    def resolve(id: , title: nil)
      standardsChart = StandardsChart.find(id)
      standardsChart.update!({
        title: title
      })
      standardsChart
    end
  end
end

# sample mutation
# mutation {
#   editStandardsChart(id: 1, title: "s") {
#     id
#     title
#   }
# }
