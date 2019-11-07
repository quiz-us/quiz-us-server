# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Mutations::Teachers::CreatePeriod' do
  let!(:teacher) { create(:teacher) }
  let!(:course) { create(:course, teacher: teacher) }
  let(:query_string) do
    <<-GRAPHQL
      mutation ($name: String!){
        createPeriod (name: $name) {
          name
          id
        }
      }
    GRAPHQL
  end
  let(:variables) { { name: Faker::Educator.subject } }

  it_behaves_like 'teacher_authenticated_endpoint'

  context 'when teacher is signed in' do
    before(:each) do
      # stub out current_course to get around authentication:
      allow_any_instance_of(Mutations::BaseMutation).to receive(:current_teacher)
        .and_return(teacher)
    end

    it 'creates a period' do
      result = QuizUsServerSchema.execute(query_string, variables: variables)
                                 .to_h['data']['createPeriod']
      expect(result['name']).to eq(variables[:name])
      expect(result['id'].to_i).to be_a_kind_of(Integer)
    end
  end
end
