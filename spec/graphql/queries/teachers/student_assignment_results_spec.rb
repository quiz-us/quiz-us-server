# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Queries::Teachers::StudentAssignmentResults' do
  let(:teacher) { create(:teacher) }
  let(:student) { create(:student) }
  let(:course) { create(:course, teacher: teacher) }
  let(:period) { create(:period, course: course) }
  let(:assignment) { create(:assignment, period: period) }
  let(:query_string) do
    <<-GRAPHQL
      query($studentId: ID!, $assignmentId: ID!) {
        studentAssignmentResults(
          studentId: $studentId
          assignmentId: $assignmentId
        ) {
          id
          richText
          questionType
          responses {
            createdAt
            id
            questionOption {
              richText
            }
            responseText
            mcCorrect
            selfGrade
          }
        }
      }
    GRAPHQL
  end
  let(:variables) do
    {
      assignmentId: assignment.id,
      studentId: student.id
    }
  end
  it_behaves_like 'teacher_authenticated_endpoint'
end
