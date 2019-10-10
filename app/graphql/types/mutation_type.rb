# frozen_string_literal: true

module Types
  class MutationType < BaseObject
    # TEACHER MUTATIONS:
    field :create_assignments, mutation: Mutations::CreateAssignments
    field :create_deck, mutation: Mutations::CreateDeck
    field :create_login_link, mutation: Mutations::CreateLoginLink
    field :create_period, mutation: Mutations::Period::CreatePeriod
    field :create_question, mutation: Mutations::CreateQuestion
    field :delete_deck, mutation: Mutations::DeleteDeck
    field :delete_period, mutation: Mutations::Period::DeletePeriod
    field :edit_period, mutation: Mutations::Period::EditPeriod
    field :edit_standards_chart, mutation: Mutations::EditStandardsChart
    field :enroll_student, mutation: Mutations::EnrollStudent
    field :log_in_teacher, mutation: Mutations::Auth::LogInTeacher
    field :sign_up_teacher, mutation: Mutations::Auth::SignUpTeacher
    field :update_deck, mutation: Mutations::UpdateDeck
    field :delete_question, mutation: Mutations::DeleteQuestion

    # STUDENT MUTATIONS:
    field :create_response, mutation: Mutations::Students::CreateResponse
    field :log_in_student, mutation: Mutations::Auth::LogInStudent
    field :log_out_student, mutation: Mutations::Auth::LogOutStudent
    field :qr_log_in_student, mutation: Mutations::Auth::QrLogInStudent
  end
end
