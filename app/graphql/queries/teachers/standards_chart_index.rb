# frozen_string_literal: true

module Queries
  module Teachers
    class StandardsChartIndex < TeacherQuery
      description 'Find all the Standards Chart'

      type [Types::StandardsChartType], null: false

      def resolve
        StandardsChart.all
      end
    end
  end
end
