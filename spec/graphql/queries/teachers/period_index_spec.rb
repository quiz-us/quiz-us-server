# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Queries::Teachers::PeriodIndex' do
  let(:teacher) { create(:teacher) }
  let(:course) { create(:course, teacher: teacher) }
  let(:query_string) do
    <<-GRAPHQL
    query getPeriods {
      periods {
        name
        id
      }
    }
    GRAPHQL
  end
  it_behaves_like 'teacher_authenticated_endpoint'

  context 'when logged in as teacher' do
    let!(:periods) do
      [
        create(:period, course: course),
        create(:period, course: course),
        create(:period, course: course)
      ]
    end
    before(:each) do
      allow_any_instance_of(Queries::BaseQuery)
        .to receive(:current_course).and_return(course)
      allow_any_instance_of(Queries::BaseQuery)
        .to receive(:current_teacher).and_return(teacher)
    end
    it "returns the teacher's periods in alphabetical order" do
      res = QuizUsServerSchema.execute(query_string)
                              .to_h['data']['periods']
      expect(res.map { |p| p['name'] }).to eq(periods.map(&:name).sort)
    end
  end
end
