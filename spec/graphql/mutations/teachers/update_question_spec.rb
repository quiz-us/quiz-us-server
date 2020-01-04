# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Mutations::Teachers::UpdateQuestion' do
  let!(:teacher) { create(:teacher) }
  let!(:course) { create(:course, teacher: teacher) }
  let(:period) { create(:period, name: 'Old Name', course: course) }
  let(:query_string) do
    <<-GRAPHQL
      mutation ($periodId: ID!, $name: String!){
        editPeriod (periodId: $periodId, name: $name) {
          name
          id
        }
      }
    GRAPHQL
  end
  let(:variables) { { name: Faker::Educator.subject, periodId: period.id } }

  it_behaves_like 'teacher_authenticated_endpoint'

  context 'when teacher is logged in' do
    before(:each) do
      # stub out current_course to get around authentication:
      allow_any_instance_of(Mutations::BaseMutation).to receive(:current_teacher)
        .and_return(teacher)
    end

    it 'edits a period' do
      result = QuizUsServerSchema.execute(
        query_string, variables: variables
      ).to_h['data']['editPeriod']

      expect(result['name']).to eq(variables[:name])
      expect(result['name']).not_to eq('Old Name')
      expect(result['id'].to_i).to eq(period.id)
    end
  end
end
