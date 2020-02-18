# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Queries::Teachers::StandardsCategoryIndex' do
  let(:teacher) { create(:teacher) }
  let(:course) { create(:course, teacher: teacher) }
  let(:query_string) do
    <<-GRAPHQL
    query standardsCategoryIndex {
      standardsCategoryIndex {
        title
        description
        id
      }
    }
    GRAPHQL
  end
  let(:variables) { nil }
  it_behaves_like 'teacher_authenticated_endpoint'

  context 'when logged in as teacher' do
    let!(:standards_categories) do
      [
        create(:standards_category, standards_chart: course.standards_chart),
        create(:standards_category, standards_chart: course.standards_chart),
        create(:standards_category, standards_chart: course.standards_chart)
      ]
    end
    before(:each) do
      allow_any_instance_of(Queries::BaseQuery)
        .to receive(:current_course).and_return(course)
      allow_any_instance_of(Queries::BaseQuery)
        .to receive(:current_teacher).and_return(teacher)
    end
    it "returns the teacher's standards categories" do
      res = QuizUsServerSchema.execute(query_string)
                              .to_h['data']['standardsCategoryIndex']
      expect(res.map { |s| s['title'] }.sort).to eq(
        standards_categories.map(&:title).sort
      )
    end
  end
end
