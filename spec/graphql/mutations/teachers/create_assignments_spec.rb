# frozen_string_literal: true

require 'rails_helper'

describe 'Mutations::Teachers::CreateAssignments' do
  let!(:period) { create(:period) }
  let!(:deck) { create(:deck) }
  let(:query_string) do
    <<-GRAPHQL
      mutation createAssignments(
        $due: DateTime!
        $periodIds: [ID!]!
        $deckId: ID!
        $instructions: String
      ) {
        createAssignments(
          due: $due
          periodIds: $periodIds
          deckId: $deckId
          instructions: $instructions
        ) {
          deck {
            id
            name
          }
          period {
            id
            name
          }
          id
        }
      }
    GRAPHQL
  end
  let(:variables) do
    {
      due: 1.week.from_now.to_s,
      periodIds: [period.id],
      deckId: deck.id,
      instructions: 'Please make sure you complete all cards.'
    }
  end
  context 'when teacher is not signed in' do
    it 'returns Unauthenticated error' do
      errors = QuizUsServerSchema.execute(query_string, variables: variables)
                                 .to_h['errors']
      expect(errors[0]['message']).to eq('Unauthenticated')
    end
  end

  context 'when teacher is signed in' do
    let(:teacher) { create(:teacher) }
    before(:each) do
      # stub out context[:current_teacher] to get around authentication:
      allow_any_instance_of(Mutations::BaseMutation).to receive(:current_teacher)
        .and_return(teacher)
    end
    it 'creates the assignments for the class period' do
      results = QuizUsServerSchema.execute(query_string, variables: variables)
                                  .to_h['data']['createAssignments']
      expect(results[0]['deck']['id'].to_i).to eq(deck.id)
      expect(results[0]['period']['id'].to_i).to eq(period.id)
    end
  end
end
