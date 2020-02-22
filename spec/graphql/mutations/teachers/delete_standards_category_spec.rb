# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Mutations::Teachers::DeleteStandardsCategory' do
  let!(:teacher) { create(:teacher) }
  let!(:course) { create(:course, teacher: teacher) }
  let!(:standards_category) do
    create(:standards_category, standards_chart: course.standards_chart)
  end
  let(:query_string) do
    <<-GRAPHQL
      mutation ($id: ID!){
        deleteStandardsCategory (id: $id) {
          id
        }
      }
    GRAPHQL
  end
  let(:variables) { { id: standards_category.id } }

  it_behaves_like 'teacher_authenticated_endpoint'

  context 'when teacher is logged in' do
    before(:each) do
      # stub out current_course to get around authentication:
      allow_any_instance_of(Mutations::BaseMutation).to receive(:current_teacher)
        .and_return(teacher)
    end
    it 'deletes a standards_category' do
      result = QuizUsServerSchema.execute(
        query_string, variables: variables
      ).to_h['data']['deleteStandardsCategory']
      expect(result['id'].to_i).to eq(variables[:id])
      expect(StandardsCategory.find_by(id: standards_category.id)).to be(nil)
    end
  end
end
