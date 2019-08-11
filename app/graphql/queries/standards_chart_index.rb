# frozen_string_literal: true

module Queries
  class StandardsChartIndex < BaseQuery
    description 'Find all the Standards Chart'

    type [Types::StandardsChartType], null: false

    def resolve
      teacher_signed_in?
      StandardsChart.all
    end
  end
end
