# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Mutations::Teachers::RemoveQuestionFromDeck' do
  let!(:teacher) { create(:teacher) }
  let!(:decks_question) { create(:decks_question) }
  let(:query_string) do
    <<-GRAPHQL
      mutation ($deckId: ID!, $questionId: ID!) {
        removeQuestionFromDeck (deckId: $deckId, questionId: $questionId) {
          question {
            id
          }
        }
      }
    GRAPHQL
  end
  let(:variables) do
    { deckId: decks_question.deck_id, questionId: decks_question.question_id }
  end

  it_behaves_like 'teacher_authenticated_endpoint'

  context 'when teacher is logged in' do
    before(:each) do
      # stub out current_course to get around authentication:
      allow_any_instance_of(Mutations::BaseMutation).to receive(:current_teacher)
        .and_return(teacher)
    end

    it 'creates a decks_question join record' do
      result = QuizUsServerSchema.execute(
        query_string, variables: variables
      ).to_h['data']['removeQuestionFromDeck']

      expect(result['question']['id'].to_i).to eq(decks_question.question_id)
      deleted = DecksQuestion.find_by(
        deck_id: decks_question.deck_id,
        question_id: decks_question.question_id
      )
      expect(deleted).to be(nil)
    end
  end
end
