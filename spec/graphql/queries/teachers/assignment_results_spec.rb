# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Queries::Teachers::AssignmentResults' do
  let(:teacher) { create(:teacher) }
  let(:course) { create(:course, teacher: teacher) }
  let(:period) { create(:period, course: course) }
  let(:assignment) { create(:assignment, period: period) }
  let(:query_string) do
    <<-GRAPHQL
      query getAssignmentsResults($assignmentId: ID!) {
        assignmentResults(assignmentId: $assignmentId) {
          firstname
          lastname
          result
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
    let!(:student_a) { create(:student) }
    let!(:student_b) { create(:student) }
    before(:each) do
      allow_any_instance_of(Queries::BaseQuery)
        .to receive(:current_teacher).and_return(teacher)
      # enroll students  in that class period so that they are assigned to
      # the assignment that matches the passed in assginment_id:
      create(:enrollment, student: student_a, period: period)
      create(:enrollment, student: student_b, period: period)

      create(
        :response,
        :multiple_choice_correct,
        assignment_id: assignment.id,
        student: student_a
      )
      create(
        :response,
        :free_response_correct,
        assignment_id: assignment.id,
        student: student_b
      )
      create(
        :response,
        :free_response_incorrect,
        assignment_id: assignment.id,
        student: student_b
      )
    end

    it 'returns the assignment results for each student in the period' do
      res = QuizUsServerSchema.execute(query_string, variables: variables)
                              .to_h['data']['assignmentResults']
      first_student = res[0]
      second_student = res[1]
      expect(first_student['firstname']).to eq(student_a.first_name)
      expect(first_student['lastname']).to eq(student_a.last_name)
      expect(first_student['result']).to eq('1 / 1')

      expect(second_student['firstname']).to eq(student_b.first_name)
      expect(second_student['lastname']).to eq(student_b.last_name)
      expect(second_student['result']).to eq('1 / 2')
    end
  end
end
