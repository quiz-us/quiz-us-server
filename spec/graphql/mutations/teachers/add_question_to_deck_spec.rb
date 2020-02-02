# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Mutations::Teachers::AddQuestionToDeck' do
  let!(:teacher) { create(:teacher) }
  let(:deck) { create(:deck) }
  let(:question) { create(:question) }
  let(:query_string) do
    <<-GRAPHQL
      mutation ($deckId: ID!, $questionId: ID!) {
        addQuestionToDeck (deckId: $deckId, questionId: $questionId) {
          question {
            id
          }
        }
      }
    GRAPHQL
  end
  let(:variables) { { deckId: deck.id, questionId: question.id } }

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
      ).to_h['data']['addQuestionToDeck']

      expect(result['question']['id'].to_i).to eq(question.id)

      decks_question = DecksQuestion.find_by(
        deck_id: deck.id,
        question_id: question.id
      )
      expect(decks_question.question_id).to eq(question.id)
      expect(decks_question.deck_id).to eq(deck.id)
    end
  end
end
