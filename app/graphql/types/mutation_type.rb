# frozen_string_literal: true

module Types
  class MutationType < BaseObject
    field :edit_standards_chart, mutation: Mutations::EditStandardsChart
    field :sign_up_teacher, mutation: Mutations::Auth::SignUpTeacher
  end
end
