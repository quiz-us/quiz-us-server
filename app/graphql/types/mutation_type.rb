# frozen_string_literal: true

module Types
  class MutationType < BaseObject
    field :create_deck, mutation: Mutations::CreateDeck
    field :create_question, mutation: Mutations::CreateQuestion
    field :edit_standards_chart, mutation: Mutations::EditStandardsChart
    field :log_in_teacher, mutation: Mutations::Auth::LogInTeacher
    field :sign_up_teacher, mutation: Mutations::Auth::SignUpTeacher
    field :update_deck, mutation: Mutations::UpdateDeck
  end
end
