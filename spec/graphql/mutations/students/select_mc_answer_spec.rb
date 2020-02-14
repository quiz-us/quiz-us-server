# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/student_authenticated_endpoint.rb'

describe 'Mutations::Students::SelectMcAnswer' do
  let(:question_option) { create(:mc_option_correct) }
  let(:unfinished_response) do
    create(:unfinished_mc_response, question: question_option.question)
  end
  let(:query_string) do
    <<-GRAPHQL
      mutation (
        $responseId: ID!
        $questionOptionId: ID!
      ){
        selectMcAnswer (
          responseId: $responseId
          questionOptionId: $questionOptionId
        ) {
          id
          questionOptionId
          mcCorrect
        }
      }
    GRAPHQL
  end
  let(:variables) do
    {
      questionOptionId: question_option.id,
      responseId: unfinished_response.id
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

    it 'grades the multiple choice question & updates the unfinished response' do
      res = QuizUsServerSchema.execute(query_string, variables: variables)
                              .to_h['data']['selectMcAnswer']
      expect(res['questionOptionId'].to_i).to eq(question_option.id)
      expect(res['mcCorrect']).to eq(true)
    end

    it 'calls CalculateDue' do
      expect(CalculateDue).to receive_message_chain(:new, :call)
      QuizUsServerSchema.execute(query_string, variables: variables)
    end

    let(:standard) { create(:standard) }
    it 'calculates the mastery for the associated standards' do
      create(
        :questions_standard,
        question: question_option.question,
        standard: standard
      )
      QuizUsServerSchema.execute(query_string, variables: variables)
      expect(
        StandardMastery.find_by(
          student: student,
          standard: standard
        ).num_attempts
      ).to eq(1)
    end
  end
end
