# frozen_string_literal: true

# query resolvers

module Types
  class QueryType < BaseObject
    # TEACHER TYPES
    field :all_standards, resolver: Queries::Teachers::StandardIndex
    field :assignment_results, resolver: Queries::Teachers::AssignmentResults
    field :deck, resolver: Queries::Teachers::DeckShow
    field :decks, resolver: Queries::Teachers::DeckIndex
    field :period_assignments, resolver: Queries::Teachers::PeriodAssignmentIndex
    field :period_standards_mastery, resolver: Queries::Teachers::PeriodStandardsMastery
    field :period, resolver: Queries::Teachers::PeriodShow
    field :periods, resolver: Queries::Teachers::PeriodIndex
    field :question_option, resolver: Queries::Teachers::QuestionOptionShow
    field :question, resolver: Queries::Teachers::QuestionShow
    field :questions, resolver: Queries::Teachers::QuestionSearch
    field :standard, resolver: Queries::Teachers::StandardShow
    field :standards_charts, resolver: Queries::Teachers::StandardsChartIndex
    field :students, resolver: Queries::Teachers::StudentIndex
    field :tag_search, resolver: Queries::Teachers::TagSearch
    field :tag, resolver: Queries::Teachers::TagShow
    field :tagging, resolver: Queries::Teachers::TaggingShow
    field :tags, resolver: Queries::Teachers::TagIndex
    field :teacher_assignment, resolver: Queries::Teachers::AssignmentShow

    # STUDENT TYPES
    field :assignment, resolver: Queries::Students::AssignmentShow
    field :current_student, resolver: Queries::Students::CurrentStudent
    field :personal_assignment, resolver: Queries::Students::PersonalAssignment
    field :standards_mastery, resolver: Queries::Students::StandardsMastery
    field :student_assignments, resolver: Queries::Students::AssignmentIndex
    field :translated_question, resolver: Queries::Students::TranslatedQuestion

    # SHARED TYPES`
    field :student_assignment_results, resolver: Queries::Shared::StudentAssignmentResults
  end
end
