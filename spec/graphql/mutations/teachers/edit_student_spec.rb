# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Mutations::Teachers::EditStudent' do
  let(:student) { create(:student) }
  # using SecureRandom.hex to avoid the chance of faker generating the same
  # updated name as the original:
  let(:updated_first_name) { SecureRandom.hex }
  let(:updated_last_name) { SecureRandom.hex }
  let(:query_string) do
    <<-GRAPHQL
      mutation editStudent($studentId: ID!, $studentParams: StudentParams!) {
        editStudent(studentId: $studentId, studentParams: $studentParams) {
          id
          firstName
          lastName
          email
        }
      }
    GRAPHQL
  end
  let(:variables) do
    {
      studentId: student.id,
      studentParams: {
        firstName: updated_first_name,
        lastName: updated_last_name
      }
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

    context 'with valid student params' do
      it 'updates the student' do
        original_first_name = student.first_name
        original_last_name = student.last_name
        results = QuizUsServerSchema.execute(query_string, variables: variables)
                                    .to_h['data']['editStudent']
        updated_student = Student.find(student.id)
        expect(results['firstName']).not_to eq(original_first_name)
        expect(updated_student.first_name).not_to eq(original_first_name)
        expect(results['lastName']).not_to eq(original_last_name)
        expect(updated_student.last_name).not_to eq(original_last_name)
      end
    end

    context 'with invalid student params' do
      it 'returns an error' do
        invalid = variables
        invalid[:studentParams][:invalid_attribute] = 'hi'
        results = QuizUsServerSchema.execute(query_string, variables: invalid)
                                    .to_h['errors']
        expect(results[0]['message']).to eq(
          'Variable studentParams of type StudentParams! was provided invalid'\
           ' value for invalid_attribute (Field is not defined on StudentParams)'
        )
      end
    end
  end
end
