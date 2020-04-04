# frozen_string_literal: true

module Types
  class CourseType < BaseObject
    description 'Course'
    field :standards_chart, Types::StandardsChartType, null: false
    field :id, ID, null: true
  end
end
