# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Queries::Teachers::CourseIndex' do
  let(:teacher) { create(:teacher) }
  let(:course) { create(:course, teacher: teacher) }
  let(:query_string) do
    <<-GRAPHQL
    query courses {
      courses {
        id
      }
    }
    GRAPHQL
  end
  let(:variables) { nil }
  it_behaves_like 'teacher_authenticated_endpoint'

  context 'when logged in as teacher' do
    before(:each) do
      allow_any_instance_of(Queries::BaseQuery)
        .to receive(:current_course).and_return(course)
      allow_any_instance_of(Queries::BaseQuery)
        .to receive(:current_teacher).and_return(teacher)
    end
    it "returns the teacher's courses" do
      res = QuizUsServerSchema.execute(query_string)
                              .to_h['data']['courses']
      expect(res.length).to eq(1)
    end
  end
end
