# frozen_string_literal: true

module Queries
  class StudentIndex < BaseQuery
    description 'Display all students for a given period'

    argument :period_id, ID, required: true

    type [Types::StudentType], null: false

    def resolve(period_id:)
      period = current_course.periods.find(period_id)
      period.students
    end
  end
end
