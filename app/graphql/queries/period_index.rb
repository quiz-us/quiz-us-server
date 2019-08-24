# frozen_string_literal: true

module Queries
  class PeriodIndex < BaseQuery
    description 'Display all periods for current course'

    type [Types::PeriodType], null: false

    def resolve
      current_course.periods
    end
  end
end
