# frozen_string_literal: true

RSpec.shared_examples 'shared_authenticated_endpoint' do
  context 'when neither student or teacher is signed in' do
    it 'returns Unauthenticated error' do
      errors = QuizUsServerSchema.execute(query_string, variables: variables)
                                 .to_h['errors']
      expect(errors[0]['message']).to eq('Unauthenticated')
    end
  end
end
