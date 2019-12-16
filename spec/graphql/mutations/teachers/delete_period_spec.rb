# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Mutations::Teachers::DeletePeriod' do
  let!(:teacher) { create(:teacher) }
  let!(:course) { create(:course, teacher: teacher) }
  let(:period) { create(:period, name: 'Old Name', course: course) }
  let(:query_string) do
    <<-GRAPHQL
      mutation ($periodId: ID!){
        deletePeriod (periodId: $periodId) {
          name
          id
        }
      }
    GRAPHQL
  end
  let(:variables) { { periodId: period.id } }

  it_behaves_like 'teacher_authenticated_endpoint'

  context 'when teacher is logged in' do
    before(:each) do
      # stub out current_course to get around authentication:
      allow_any_instance_of(Mutations::BaseMutation).to receive(:current_teacher)
        .and_return(teacher)
    end
    it 'deletes a period' do
      result = QuizUsServerSchema.execute(
        query_string, variables: variables
      ).to_h['data']['deletePeriod']

      expect(result['name']).to eq('Old Name')
      expect(result['id'].to_i).to eq(variables[:periodId])
      expect(Period.find_by(id: period.id)).to be(nil)
    end
  end
end
