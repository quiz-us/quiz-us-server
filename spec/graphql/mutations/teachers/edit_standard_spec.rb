# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Mutations::Teachers::EditStandard' do
  let!(:teacher) { create(:teacher) }
  let!(:standard) do
    create(:standard, title: 'Old Name', description: 'Old Description')
  end
  let(:query_string) do
    <<-GRAPHQL
      mutation ($id: ID!, $title: String!, $description: String!){
        editStandard (id: $id, title: $title, description: $description) {
          title
          description
          id
        }
      }
    GRAPHQL
  end
  let(:variables) do
    {
      title: Faker::Educator.subject,
      description: Faker::Lorem.sentence,
      id: standard.id
    }
  end

  it_behaves_like 'teacher_authenticated_endpoint'

  context 'when teacher is logged in' do
    before(:each) do
      # stub out current_course to get around authentication:
      allow_any_instance_of(Mutations::BaseMutation).to receive(:current_teacher)
        .and_return(teacher)
    end

    it 'edits a standard' do
      result = QuizUsServerSchema.execute(
        query_string, variables: variables
      ).to_h['data']['editStandard']

      expect(result['title']).to eq(variables[:title])
      expect(result['title']).not_to eq('Old Name')
      expect(result['description']).to eq(variables[:description])
      expect(result['description']).not_to eq('Old Description')
      expect(result['id'].to_i).to eq(standard.id)
    end
  end
end
