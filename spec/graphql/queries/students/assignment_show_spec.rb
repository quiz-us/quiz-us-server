# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/student_authenticated_endpoint.rb'

describe 'Queries::Students::AssignmentShow' do
  let(:student) { create(:student) }
  let(:period) { create(:period) }
  let!(:enrollment) { create(:enrollment, student: student, period: period) }
  let(:assignment) { create(:assignment, period: period) }
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
    before(:each) do
      allow_any_instance_of(Queries::BaseQuery)
        .to receive(:current_student).and_return(student)
    end
    it 'returns the correct assignment' do
      res = QuizUsServerSchema.execute(query_string, variables: variables)
                              .to_h['data']['assignment']

      expect(res['id'].to_i).to eq(assignment.id)
    end
  end
end
