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
    let(:mc_question) { create(:question, question_type: 'Multiple Choice') }
    let(:fr_question) { create(:question, question_type: 'Free Response') }
    before(:each) do
      allow_any_instance_of(Queries::BaseQuery)
        .to receive(:current_student).and_return(student)
      create(:questions_standard, question: mc_question, standard: standard_1)
      create(:questions_standard, question: fr_question, standard: standard_2)
    end
    it 'returns the student performance on each encountered standard' do
      create(:response, question: mc_question, mc_correct: true, student: student)
      create(:response, question: mc_question, mc_correct: false, student: student)
      create(
        :response,
        question: fr_question,
        student: student,
        mc_correct: nil,
        self_grade: 4
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
