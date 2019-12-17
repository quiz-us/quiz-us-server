# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Queries::Teachers::PeriodStandardsSummary' do
  let(:teacher) { create(:teacher) }
  let(:standards_chart) { create(:standards_chart) }
  let(:standards_category) do
    create(:standards_category, standards_chart: standards_chart)
  end
  let(:standard) { create(:standard, standards_category: standards_category) }
  let(:course) do
    create(:course, teacher: teacher, standards_chart: standards_chart)
  end
  let(:period) { create(:period, course: course) }
  let(:students) do
    [
      create(:student),
      create(:student)
    ]
  end
  let!(:enrollments) do
    [
      create(:enrollment, student: students[0], period: period),
      create(:enrollment, student: students[1], period: period)
    ]
  end
  let!(:masteries) do
    [
      create(
        :standard_mastery,
        student: students[0],
        standard: standard,
        num_attempts: 2,
        num_correct: 1
      ),
      create(
        :standard_mastery,
        student: students[1],
        standard: standard,
        num_attempts: 2,
        num_correct: 2
      )
    ]
  end
  let(:query_string) do
    <<-GRAPHQL
      query getPeriodSummary($periodId: ID!) {
        periodStandardsSummary(periodId: $periodId) {
          standard {
            title
            description
          }
          numCorrect
          numAttempts
          percentCorrect
        }
      }
    GRAPHQL
  end
  let(:variables) do
    {
      periodId: period.id
    }
  end
  it_behaves_like 'teacher_authenticated_endpoint'

  context 'when logged in as teacher' do
    before(:each) do
      allow_any_instance_of(Queries::BaseQuery)
        .to receive(:current_teacher).and_return(teacher)
    end
    it "returns the teacher's periods in alphabetical order" do
      res = QuizUsServerSchema.execute(query_string, variables: variables)
                              .to_h['data']['periodStandardsSummary']
      expect(res).to eq([
                          {
                            'standard' => {
                              'title' => standard.title,
                              'description' => standard.description
                            },
                            'numCorrect' => masteries.sum(&:num_correct),
                            'numAttempts' => masteries.sum(&:num_attempts),
                            'percentCorrect' => masteries.sum(&:num_correct).to_f / masteries.sum(&:num_attempts) * 100
                          }
                        ])
    end
  end
end
