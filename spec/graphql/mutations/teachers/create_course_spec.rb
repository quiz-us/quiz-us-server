# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Mutations::Teachers::CreateCourse' do
  let!(:teacher) { create(:teacher) }
  let(:query_string) do
    <<-GRAPHQL
      mutation ($title: String!){
        createCourse (title: $title) {
          id
        }
      }
    GRAPHQL
  end
  let(:variables) { { title: Faker::Educator.subject } }

  it_behaves_like 'teacher_authenticated_endpoint'

  context 'when teacher is signed in' do
    before(:each) do
      # stub out current_course to get around authentication:
      allow_any_instance_of(Mutations::BaseMutation).to receive(:current_teacher)
        .and_return(teacher)
    end

    it 'creates a course' do
      result = QuizUsServerSchema.execute(query_string, variables: variables)
                                 .to_h['data']['createCourse']
      expect(result['id'].to_i).to eq(teacher.courses.last.id)
    end
  end
end
