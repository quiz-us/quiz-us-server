# frozen_string_literal: true

# teacher_authenticated_endpoint is a
# shared example group (https://engineering.entelo.com/effective-use-of-rspec-shared-examples-80aeead78833)
# that tests that a teacher is logged in before the mutation or query can execute.
#
# In order for this shared example group to work, the spec running this
# example must have a `query_string` and `variables` defined as a memoized
# `let` helper.
# You can find an example of this at:
# 'spec/graphql/mutations/teachers/create_assignments_spec.rb'

RSpec.shared_examples 'teacher_authenticated_endpoint' do
  context 'when teacher is not signed in' do
    it 'returns Unauthenticated error' do
      # account for when variables don't need to be passed in:
      variables ||= nil
      errors = QuizUsServerSchema.execute(query_string, variables: variables)
                                 .to_h['errors']
      expect(errors[0]['message']).to eq('Unauthenticated')
    end
  end
end
