# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/student_authenticated_endpoint.rb'

describe 'Mutations::Students::CreateResponse' do
  let(:question) { create(:question) }
  let(:query_string) do
    <<-GRAPHQL
      mutation (
        $questionId: ID!
        $assignmentId: ID
        $questionOptionId: ID
        $responseText: String
        $selfGrade: Int
        $questionType: String!
      ){
        createResponse (
          questionId: $questionId
          assignmentId: $assignmentId
          questionOptionId: $questionOptionId
          responseText: $responseText
          selfGrade: $selfGrade
          questionType: $questionType
        ) {
          id
        }
      }
    GRAPHQL
  end
  let(:variables) do
    {
      questionId: question.id,
      responseText: Faker::Lorem.sentence,
      selfGrade: Faker::Number.between(from: 1, to: 5),
      questionType: 'Free Response'
    }
  end

  it_behaves_like 'student_authenticated_endpoint'

  context 'when logged in as student' do
    let(:student) { create(:student) }
    let!(:personal_deck) { create(:deck, owner: student) }
    before(:each) do
      allow_any_instance_of(Mutations::BaseMutation)
        .to receive(:current_student).and_return(student)
    end
    it 'creates a response' do
      initial_count = Response.count
      res = QuizUsServerSchema.execute(query_string, variables: variables).to_h['data']['createResponse']
      expect(Response.count).to eq(initial_count + 1)
      expect(student.responses.last.id).to eq(res['id'].to_i)
    end
    it 'calls CalculateDue' do
      expect(CalculateDue).to receive_message_chain(:new, :call)
      QuizUsServerSchema.execute(query_string, variables: variables)
    end
  end
end
