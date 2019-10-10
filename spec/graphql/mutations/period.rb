# frozen_string_literal: true

require 'rails_helper'

describe 'period mutations' do
  describe 'create' do
    let(:course) { create(:course) }
    before(:each) do
      # stub out current_course to get around authentication:
      allow_any_instance_of(Mutations::Period::CreatePeriod).to receive(
        :current_course
      ).and_return(course)
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

  describe 'edit and delete' do
    let(:period) { create(:period, name: 'Old Name') }
    let(:course) { period.course }
    before(:each) do
      # stub out current_course to get around authentication:
      allow_any_instance_of(Mutations::Period::EditPeriod).to receive(
        :current_course
      ).and_return(course)

      allow_any_instance_of(Mutations::Period::DeletePeriod).to receive(
        :current_course
      ).and_return(course)
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
end
