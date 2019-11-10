# frozen_string_literal: true

# query resolvers

module Types
  class QueryType < BaseObject
    # TEACHER TYPES
    field :assignment_results, resolver: Queries::Teachers::AssignmentResults
    field :deck, resolver: Queries::Teachers::DeckShow
    field :decks, resolver: Queries::Teachers::DeckIndex
    field :period, resolver: Queries::Teachers::PeriodShow
    field :period_assignments, resolver: Queries::Teachers::PeriodAssignmentIndex
    field :period_standards_mastery, resolver: Queries::Teachers::PeriodStandardsMastery
    field :periods, resolver: Queries::Teachers::PeriodIndex
    field :question, resolver: Queries::Teachers::QuestionShow
    field :questions, resolver: Queries::Teachers::QuestionSearch
    field :standards_charts, resolver: Queries::Teachers::StandardsChartIndex
    field :tag, resolver: Queries::Teachers::TagShow
    field :tagging, resolver: Queries::Teachers::TaggingShow
    field :standard, resolver: Queries::Teachers::StandardShow
    field :all_standards, resolver: Queries::Teachers::StandardIndex
    field :question_option, resolver: Queries::Teachers::QuestionOptionShow
    field :students, resolver: Queries::Teachers::StudentIndex
    field :tags, resolver: Queries::Teachers::TagIndex
    field :tag_search, resolver: Queries::Teachers::TagSearch
    field :teacher_assignment, resolver: Queries::Teachers::AssignmentShow

    # STUDENT TYPES
    field :current_student, resolver: Queries::Students::CurrentStudent
    field :assignment, resolver: Queries::Students::AssignmentShow
    field :personal_assignment, resolver: Queries::Students::PersonalAssignment
    field :student_assignments, resolver: Queries::Students::AssignmentIndex
  end
end
