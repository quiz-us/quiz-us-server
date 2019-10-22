# frozen_string_literal: true

describe 'Mutations::Teachers::DeletePeriod' do
  let!(:teacher) { create(:teacher) }
  let!(:course) { create(:course, teacher: teacher) }
  let(:period) { create(:period, name: 'Old Name', course: course) }
  before(:each) do
    # stub out current_course to get around authentication:
    allow_any_instance_of(Mutations::BaseMutation).to receive(:current_teacher)
      .and_return(teacher)
  end
  it 'deletes a period' do
    query_string = <<-GRAPHQL
        mutation ($periodId: ID!){
          deletePeriod (periodId: $periodId) {
            name
            id
          }
        }
    GRAPHQL

    result = QuizUsServerSchema.execute(
      query_string, variables: { periodId: period.id }
    ).to_h['data']['deletePeriod']

    expect(result['name']).to eq('Old Name')
    expect(result['id'].to_i).to eq(period.id)
    expect(Period.find_by(id: period.id)).to be(nil)
  end
end
