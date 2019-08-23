# frozen_string_literal: true

module Types
  class MutationType < BaseObject
    field :create_deck, mutation: Mutations::CreateDeck
    field :create_login_link, Mutation::CreateLoginLink
    field :create_question, mutation: Mutations::CreateQuestion
    field :delete_deck, mutation: Mutations::DeleteDeck
    field :edit_standards_chart, mutation: Mutations::EditStandardsChart
    field :log_in_student, mutation: Mutations::Auth::LogInStudent
    field :log_in_teacher, mutation: Mutations::Auth::LogInTeacher
    field :sign_up_teacher, mutation: Mutations::Auth::SignUpTeacher
    field :update_deck, mutation: Mutations::UpdateDeck
  end
end
