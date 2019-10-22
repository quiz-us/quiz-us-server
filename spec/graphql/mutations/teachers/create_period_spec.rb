# frozen_string_literal: true

require 'rails_helper'

describe 'Mutations::Teachers::CreatePeriod' do
  let!(:teacher) { create(:teacher) }
  let!(:course) { create(:course, teacher: teacher) }
  before(:each) do
    # stub out current_course to get around authentication:
    allow_any_instance_of(Mutations::BaseMutation).to receive(:current_teacher)
      .and_return(teacher)
  end
  it 'creates a period' do
    query_string = <<-GRAPHQL
      mutation ($name: String!){
        createPeriod (name: $name) {
          name
          id
        }
      }
    GRAPHQL
    name = Faker::Educator.subject
    result = QuizUsServerSchema.execute(query_string, variables: { name: name })
                               .to_h['data']['createPeriod']
    expect(result['name']).to eq(name)
    expect(result['id'].to_i).to be_a_kind_of(Integer)
  end
end
