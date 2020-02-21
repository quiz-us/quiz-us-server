# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Mutations::Teachers::CreateStandard' do
  let!(:teacher) { create(:teacher) }
  let!(:course) { create(:course, teacher: teacher) }
  let!(:standards_category) do
    create(:standards_category, standards_chart: course.standards_chart)
  end
  let(:query_string) do
    <<-GRAPHQL
      mutation createStandard(
        $categoryId: ID!
        $title: String!
        $description: String!
      ) {
        createStandard(
          categoryId: $categoryId
          title: $title
          description: $description
        ) {
          id
          title
          description
          standardsCategory {
            id
            title
          }
        }
      }
    GRAPHQL
  end
  let(:variables) do
    {
      categoryId: standards_category.id,
      title: Faker::Educator.subject,
      description: Faker::String.random
    }
  end

  it_behaves_like 'teacher_authenticated_endpoint'

  context 'when teacher is signed in' do
    before(:each) do
      # stub out current_course to get around authentication:
      allow_any_instance_of(Mutations::BaseMutation).to receive(:current_teacher)
        .and_return(teacher)
    end

    it 'creates a standard' do
      result = QuizUsServerSchema.execute(query_string, variables: variables)
                                 .to_h['data']['createStandard']
      expect(result['title']).to eq(variables[:title])
      expect(result['description']).to eq(variables[:description])
      expect(result['id'].to_i).to be_a_kind_of(Integer)
      expect(result['standardsCategory']['id'].to_i).to eq(
        variables[:categoryId]
      )
      expect(Standard.find(result['id'])).to be_truthy
    end
  end
end
