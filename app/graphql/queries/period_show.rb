# frozen_string_literal: true

module Queries
  class PeriodShow < BaseQuery
    description 'Displays a period given a period id'

    argument :period_id, ID, required: true
    type Types::PeriodType, null: false

    def resolve(period_id:)
      teacher_signed_in?
      Period.find(period_id)
    end
  end
end
