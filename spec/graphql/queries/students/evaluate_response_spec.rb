# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/student_authenticated_endpoint.rb'

describe 'Queries::Students::EvaluateResponse' do
  let(:student) { create(:student) }
  let(:question) { create(:question) }
  let!(:question_option) do
    create(:question_option, question: question, correct: true)
  end
  let(:student_response) { create(:response, question: question) }

  let(:query_string) do
    <<-GRAPHQL
      query evaluateResponse($responseId: ID!, $responseText: String!) {
        evaluateResponse(responseId: $responseId, responseText: $responseText) {
          percent
        }
      }
    GRAPHQL
  end
  let(:variables) do
    {
      responseText: 'Hello World',
      responseId: student_response.id
    }
  end

  it_behaves_like 'student_authenticated_endpoint'

  context 'when logged in as student' do
    before(:each) do
      allow_any_instance_of(Queries::BaseQuery)
        .to receive(:current_student).and_return(student)

      allow(CompareText).to receive(:call).and_return(
        { similarity: 0.25 }.to_json
      )
    end
    it 'calls CompareText' do
      res = QuizUsServerSchema.execute(query_string, variables: variables)
                              .to_h['data']['evaluateResponse']

      expect(res).to eq(
        { 'percent' => 25.0 }
      )
    end
  end
end
