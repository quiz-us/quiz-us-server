# frozen_string_literal: true

# query resolvers

module Types
  class QueryType < BaseObject
    # TEACHER TYPES
    field :deck, resolver: Queries::DeckShow
    field :decks, resolver: Queries::DeckIndex
    field :periods, resolver: Queries::PeriodIndex
    field :standards_charts, resolver: Queries::StandardsChartIndex
    field :question, resolver: Queries::QuestionShow
    field :questions, resolver: Queries::QuestionSearch
    field :tag, resolver: Queries::TagShow
    field :tagging, resolver: Queries::TaggingShow
    field :standard, resolver: Queries::StandardShow
    field :all_standards, resolver: Queries::StandardIndex
    field :question_option, resolver: Queries::QuestionOptionShow
    field :students, resolver: Queries::StudentIndex
    field :tags, resolver: Queries::TagIndex
    field :tag_search, resolver: Queries::TagSearch

    # STUDENT TYPES
    field :current_student, resolver: Queries::Students::CurrentStudent
    field :student_assignments, resolver: Queries::Students::AssignmentIndex
  end
end
