# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/student_authenticated_endpoint.rb'

describe 'Queries::Students::AssignmentShow' do
  let(:student) { create(:student) }
  let(:assignment) { create(:question) }
  let(:query_string) do
    <<-GRAPHQL
      query ($assignmentId: ID!, $studentId: ID!){
        assignment (
          assignmentId: $assignmentId
          studentId: $studentId
        ) {
          id
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

  it_behaves_like 'student_authenticated_endpoint'

  context 'when logged in as student' do
  end
end
