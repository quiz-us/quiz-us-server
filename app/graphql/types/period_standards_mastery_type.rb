# frozen_string_literal: true

module Types
  class PeriodStandardsMasteryType < BaseObject
    description 'Standards mastery data for a period'
    field :standard, Types::StandardType, null: false
    field :student_performance, String, null: false
  end
end
