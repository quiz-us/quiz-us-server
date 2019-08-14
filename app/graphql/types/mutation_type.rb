module Types
  class MutationType < BaseObject
    field :edit_standards_chart, mutation: Mutations::EditStandardsChart
    field :create_question, mutation: Mutations::CreateQuestion
  end
end
