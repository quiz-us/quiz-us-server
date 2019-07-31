
module Mutations
  class CreateQuestion < BaseMutation
    graphql_name 'Create Question'
    description "Create Question"

    # arguments passed to the `resolved` method
    argument :question_node, String, required: true
    argument :question_type, String, required: true
    argument :question_tags, String, required: false

    # return type from the mutation
    type Types::QuestionType

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

