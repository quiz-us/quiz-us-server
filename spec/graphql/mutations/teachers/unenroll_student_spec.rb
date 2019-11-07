# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Mutations::Teachers::UnenrollStudent' do
  let(:student) { create(:student) }
  let(:period) { create(:period) }
  let(:query_string) do
    <<-GRAPHQL
      mutation unenrollStudent($studentId: ID!, $periodId: ID!) {
        unenrollStudent(studentId: $studentId, periodId: $periodId) {
          id
          firstName
          lastName
        }
      }
    GRAPHQL
  end
  let(:variables) do
    {
      studentId: student.id,
      periodId: period.id
    }
  end

  it_behaves_like 'teacher_authenticated_endpoint'

  context 'when teacher is signed in' do
    let(:teacher) { create(:teacher) }
    before(:each) do
      # stub out context[:current_teacher] to get around authentication:
      allow_any_instance_of(Mutations::BaseMutation).to receive(:current_teacher)
        .and_return(teacher)
    end

    context 'when period does not belong to a teacher' do
      it 'raises a GraphQL execution error' do
        errors = QuizUsServerSchema.execute(query_string, variables: variables)
                                   .to_h['errors']

        expect(errors[0]['message']).to eq(
          'You can only unenroll students in your classes'
        )
      end
    end

    context 'when a period does belong to a teacher' do
      let(:valid_course) { create(:course, teacher: teacher) }
      let(:valid_period) { create(:period, course: valid_course) }
      before(:each) do
        create(:enrollment, student: student, period: valid_period)
      end
      it 'unenrolls the student from the period by destroying the enrollment' do
        results = QuizUsServerSchema.execute(query_string, variables: {
                                               studentId: student.id,
                                               periodId: valid_period.id
                                             }).to_h['data']['unenrollStudent']

        expect(results['firstName']).to eq(student.first_name)
        expect(results['lastName']).to eq(student.last_name)
        expect(results['id'].to_i).to eq(student.id)
      end
    end
  end
end
