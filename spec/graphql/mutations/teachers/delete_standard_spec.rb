# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Mutations::Teachers::DeleteStandard' do
  let!(:teacher) { create(:teacher) }
  let!(:standard) { create(:standard) }
  let(:query_string) do
    <<-GRAPHQL
      mutation ($id: ID!){
        deleteStandard (id: $id) {
          id
          title
        }
      }
    GRAPHQL
  end
  let(:variables) { { id: standard.id } }

  it_behaves_like 'teacher_authenticated_endpoint'

  context 'when teacher is logged in' do
    before(:each) do
      # stub out current_course to get around authentication:
      allow_any_instance_of(Mutations::BaseMutation).to receive(:current_teacher)
        .and_return(teacher)
    end
    it 'deletes a standard' do
      result = QuizUsServerSchema.execute(
        query_string, variables: variables
      ).to_h['data']['deleteStandard']
      expect(result['id'].to_i).to eq(variables[:id])
      expect(result['title']).to eq(standard.title)
      expect(Standard.find_by(id: standard.id)).to be(nil)
    end
  end
end
