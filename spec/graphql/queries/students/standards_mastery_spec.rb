# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/student_authenticated_endpoint.rb'

describe 'Queries::Students::StandardsMastery' do
  let(:student) { create(:student) }
  let(:query_string) do
    <<-GRAPHQL
      query {
        standardsMastery {
          standard {
            title
          }
          numCorrect
          numAttempted
        }
      }
    GRAPHQL
  end
  let(:variables) do
    {
      studentId: student.id
    }
  end

  it_behaves_like 'student_authenticated_endpoint'

  context 'when logged in as student' do
    let(:standard_1) { create(:standard) }
    let(:standard_2) { create(:standard) }
    before(:each) do
      allow_any_instance_of(Queries::BaseQuery)
        .to receive(:current_student).and_return(student)
    end
    it 'returns the student performance on each encountered standard' do
      create(
        :standard_mastery,
        standard: standard_1,
        student: student,
        num_attempts: 2,
        num_correct: 1
      )
      create(
        :standard_mastery,
        standard: standard_2,
        student: student,
        num_attempts: 1,
        num_correct: 1
      )
      res = QuizUsServerSchema.execute(query_string, variables: variables)
                              .to_h['data']['standardsMastery']

      expect(res).to eq([
                          {
                            'numAttempted' => 2,
                            'numCorrect' => 1,
                            'standard' => { 'title' => standard_1.title }
                          },
                          {
                            'numAttempted' => 1,
                            'numCorrect' => 1,
                            'standard' => { 'title' => standard_2.title }
                          }
                        ])
    end
  end
end
