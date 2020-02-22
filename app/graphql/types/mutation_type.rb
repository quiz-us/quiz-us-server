# frozen_string_literal: true

module Types
  class MutationType < BaseObject
    # TEACHER MUTATIONS:
    field :add_question_to_deck, mutation: Mutations::Teachers::AddQuestionToDeck
    field :create_assignments, mutation: Mutations::Teachers::CreateAssignments
    field :create_deck, mutation: Mutations::Teachers::CreateDeck
    field :create_period, mutation: Mutations::Teachers::CreatePeriod
    field :create_question, mutation: Mutations::Teachers::CreateQuestion
    field :create_standard, mutation: Mutations::Teachers::CreateStandard
    field :create_standards_category, mutation: Mutations::Teachers::CreateStandardsCategory
    field :delete_deck, mutation: Mutations::Teachers::DeleteDeck
    field :delete_period, mutation: Mutations::Teachers::DeletePeriod
    field :delete_question, mutation: Mutations::Teachers::DeleteQuestion
    field :delete_standard, mutation: Mutations::Teachers::DeleteStandard
    field :delete_standards_category, mutation: Mutations::Teachers::DeleteStandardsCategory
    field :edit_period, mutation: Mutations::Teachers::EditPeriod
    field :edit_standard, mutation: Mutations::Teachers::EditStandard
    field :edit_standards_category, mutation: Mutations::Teachers::EditStandardsCategory
    field :edit_standards_chart, mutation: Mutations::Teachers::EditStandardsChart
    field :edit_student, mutation: Mutations::Teachers::EditStudent
    field :enroll_student, mutation: Mutations::Teachers::EnrollStudent
    field :log_in_teacher, mutation: Mutations::Teachers::LogInTeacher
    field :remove_question_from_deck, mutation: Mutations::Teachers::RemoveQuestionFromDeck
    field :sign_up_teacher, mutation: Mutations::Teachers::SignUpTeacher
    field :unenroll_student, mutation: Mutations::Teachers::UnenrollStudent
    field :update_deck, mutation: Mutations::Teachers::UpdateDeck
    field :update_question, mutation: Mutations::Teachers::UpdateQuestion

    # # STUDENT MUTATIONS:
    field :create_login_link, mutation: Mutations::Students::CreateLoginLink
    field :create_response, mutation: Mutations::Students::CreateResponse
    field :log_in_student, mutation: Mutations::Students::LogInStudent
    field :log_out_student, mutation: Mutations::Students::LogOutStudent
    field :qr_log_in_student, mutation: Mutations::Students::QrLogInStudent
    field :rate_fr_answer, mutation: Mutations::Students::RateFrAnswer
    field :select_mc_answer, mutation: Mutations::Students::SelectMcAnswer
    field :submit_fr_answer, mutation: Mutations::Students::SubmitFrAnswer
  end
end
