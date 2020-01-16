# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Queries::Teachers::QuestionSearch' do
  question_text = 'This is a match!'
  let(:teacher) { create(:teacher) }
  let(:standards_chart) { create(:standards_chart) }
  let(:standards_category) do
    create(:standards_category, standards_chart: standards_chart)
  end
  let(:standard) { create(:standard, standards_category: standards_category) }
  let(:course) do
    create(:course, teacher: teacher, standards_chart: standards_chart)
  end
  let(:question) { create(:question, question_text: question_text) }
  let!(:questions_standard) do
    create(:questions_standard, question: question, standard: standard)
  end
  let(:query_string) do
    <<-GRAPHQL
      query getQuestions($standardId: ID, $keyWords: String) {
        questions(
          standardId: $standardId
          keyWords: $keyWords
        ) {
          questionText
          questionType
          richText
          id
          standards {
            title
          }
          tags {
            name
          }
          questionOptions {
            richText
            correct
            id
          }
        }
      }
    GRAPHQL
  end

  before(:each) do
    allow_any_instance_of(Queries::BaseQuery)
      .to receive(:current_course).and_return(course)
  end
  let(:variables) do
    {
      standardId: standard.id,
      keyWords: ''
    }
  end

  it_behaves_like 'teacher_authenticated_endpoint'

  context 'when logged in as teacher' do
    let(:teacher) { create(:teacher) }
    before(:each) do
      allow_any_instance_of(Queries::BaseQuery)
        .to receive(:current_teacher).and_return(teacher)
    end
    it 'finds questions by standard id' do
      res = QuizUsServerSchema.execute(query_string, variables: variables)
                              .to_h['data']['questions']
      expect(res[0]['id'].to_i).to eq(question.id)
    end

    context 'when question_text matches' do
      it 'returns the matching questions' do
        res = QuizUsServerSchema.execute(
          query_string,
          variables: { keyWords: 'match' }
        ).to_h['data']['questions']
        expect(res[0]['id'].to_i).to eq(question.id)
      end
    end

    context 'when question_text does not match' do
      it 'does not return the question' do
        res = QuizUsServerSchema.execute(
          query_string,
          variables: { keyWords: 'RANDO BANDO' }
        ).to_h['data']['questions']
        expect(res.length).to eq(0)
      end
    end

    context 'when no filter fields are passed in' do
      it 'does not return any questions' do
        res = QuizUsServerSchema.execute(query_string, variables: {})
                                .to_h['data']['questions']
        expect(res.length).to eq(0)
      end
    end
  end
end
