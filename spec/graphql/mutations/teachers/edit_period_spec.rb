# frozen_string_literal: true

require 'rails_helper'

describe 'Mutations::Teachers::EditPeriod' do
  let!(:teacher) { create(:teacher) }
  let!(:course) { create(:course, teacher: teacher) }
  let(:period) { create(:period, name: 'Old Name', course: course) }
  before(:each) do
    # stub out current_course to get around authentication:
    allow_any_instance_of(Mutations::BaseMutation).to receive(:current_teacher)
      .and_return(teacher)
  end

  it 'edits a period' do
    query_string = <<-GRAPHQL
        mutation ($periodId: ID!, $name: String!){
          editPeriod (periodId: $periodId, name: $name) {
            name
            id
          }
        }
    GRAPHQL
    name = Faker::Educator.subject
    result = QuizUsServerSchema.execute(
      query_string, variables: { name: name, periodId: period.id }
    ).to_h['data']['editPeriod']

    expect(result['name']).to eq(name)
    expect(result['name']).not_to eq('Old Name')
    expect(result['id'].to_i).to eq(period.id)
  end
end
