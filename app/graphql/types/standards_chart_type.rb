module Types
  class StandardsChartType < BaseObject
    description "Standards Chart Description"
    field :id, ID, null: false
    field :title, String, null: true
  end
end
