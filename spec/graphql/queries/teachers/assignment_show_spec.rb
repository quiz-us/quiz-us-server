# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Queries::Teachers::AssignmentShow' do
  let(:teacher) { create(:teacher) }
  let(:course) { create(:course, teacher: teacher) }
  let(:period) { create(:period, course: course) }
  let(:assignment) { create(:assignment, period: period) }
  let(:query_string) do
    <<-GRAPHQL
      query ($assignmentId: ID!){
        teacherAssignment (
          assignmentId: $assignmentId
        ) {
          id
        }
      }
    GRAPHQL
  end
  let(:variables) do
    {
      assignmentId: assignment.id
    }
  end
  it_behaves_like 'teacher_authenticated_endpoint'

  context 'when logged in as teacher' do
    let(:teacher) { create(:teacher) }
    before(:each) do
      allow_any_instance_of(Queries::BaseQuery)
        .to receive(:current_teacher).and_return(teacher)
    end
    it 'returns the correct assignment' do
      res = QuizUsServerSchema.execute(query_string, variables: variables)
                              .to_h['data']['teacherAssignment']

      expect(res['id'].to_i).to eq(assignment.id)
    end
  end
end
