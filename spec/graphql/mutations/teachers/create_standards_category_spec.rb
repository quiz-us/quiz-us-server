# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Mutations::Teachers::CreateStandardsCategory' do
  let!(:teacher) { create(:teacher) }
  let!(:course) { create(:course, teacher: teacher) }
  let(:query_string) do
    <<-GRAPHQL
      mutation createStandardsCategory($title: String!, $description: String!) {
        createStandardsCategory(title: $title, description: $description) {
          title
          description
          id
        }
      }
    GRAPHQL
  end
  let(:variables) do
    { title: Faker::Educator.subject, description: Faker::String.random }
  end

  it_behaves_like 'teacher_authenticated_endpoint'

  context 'when teacher is signed in' do
    before(:each) do
      # stub out current_course to get around authentication:
      allow_any_instance_of(Mutations::BaseMutation).to receive(:current_teacher)
        .and_return(teacher)
    end

    it 'creates a period' do
      result = QuizUsServerSchema.execute(query_string, variables: variables)
                                 .to_h['data']['createStandardsCategory']
      expect(result['title']).to eq(variables[:title])
      expect(result['description']).to eq(variables[:description])
      expect(result['id'].to_i).to be_a_kind_of(Integer)
      expect(StandardsCategory.find(result['id'])).to be_truthy
    end
  end
end
