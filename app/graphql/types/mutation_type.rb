# frozen_string_literal: true

module Types
  class MutationType < BaseObject
    # TEACHER MUTATIONS:
    field :create_assignments, mutation: Mutations::Teachers::CreateAssignments
    field :create_deck, mutation: Mutations::Teachers::CreateDeck
    field :create_period, mutation: Mutations::Teachers::CreatePeriod
    field :create_question, mutation: Mutations::Teachers::CreateQuestion
    field :delete_deck, mutation: Mutations::Teachers::DeleteDeck
    field :delete_period, mutation: Mutations::Teachers::DeletePeriod
    field :delete_question, mutation: Mutations::Teachers::DeleteQuestion
    field :edit_period, mutation: Mutations::Teachers::EditPeriod
    field :edit_standards_chart, mutation: Mutations::Teachers::EditStandardsChart
    field :enroll_student, mutation: Mutations::Teachers::EnrollStudent
    field :log_in_teacher, mutation: Mutations::Teachers::LogInTeacher
    field :sign_up_teacher, mutation: Mutations::Teachers::SignUpTeacher
    field :unenroll_student, mutation: Mutations::Teachers::UnenrollStudent
    field :update_deck, mutation: Mutations::Teachers::UpdateDeck

    # # STUDENT MUTATIONS:
    field :create_login_link, mutation: Mutations::Students::CreateLoginLink
    field :create_response, mutation: Mutations::Students::CreateResponse
    field :log_in_student, mutation: Mutations::Students::LogInStudent
    field :log_out_student, mutation: Mutations::Students::LogOutStudent
    field :qr_log_in_student, mutation: Mutations::Students::QrLogInStudent
  end
end
