# frozen_string_literal: true

module Types
  class MutationType < BaseObject
    # TEACHER MUTATIONS:
    field :enroll_student, mutation: Mutations::EnrollStudent
    field :log_in_teacher, mutation: Mutations::Auth::LogInTeacher
    field :sign_up_teacher, mutation: Mutations::Auth::SignUpTeacher
    field :create_login_link, mutation: Mutations::CreateLoginLink

    field :create_period, mutation: Mutations::CreatePeriod
    field :create_assignments, mutation: Mutations::CreateAssignments
    field :edit_standards_chart, mutation: Mutations::EditStandardsChart

    field :create_deck, mutation: Mutations::CreateDeck
    field :update_deck, mutation: Mutations::UpdateDeck
    field :delete_deck, mutation: Mutations::DeleteDeck

    field :create_question, mutation: Mutations::CreateQuestion
    field :update_question, mutation: Mutations::UpdateQuestion
    field :delete_question, mutation: Mutations::DeleteQuestion

    # STUDENT MUTATIONS:
    field :log_in_student, mutation: Mutations::Auth::LogInStudent
    field :log_out_student, mutation: Mutations::Auth::LogOutStudent
    field :qr_log_in_student, mutation: Mutations::Auth::QrLogInStudent

    field :create_response, mutation: Mutations::Students::CreateResponse
  end
end
