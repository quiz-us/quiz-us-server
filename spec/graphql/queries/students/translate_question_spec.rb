# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/student_authenticated_endpoint.rb'

describe 'Queries::Students::TranslateQuestion' do
  let(:student) { create(:student) }
  let(:question) do
    create(
      :question,
      question_type: 'Free Response',
      question_text: 'hello'
    )
  end
  let(:query_string) do
    <<-GRAPHQL
      query translatedQuestion($questionId: ID!) {
        translatedQuestion(questionId: $questionId) {
          questionText
          translatedQuestionText
          questionOptions {
            optionText
            translatedOptionText
          }
        }
      }
    GRAPHQL
  end
  let(:variables) do
    {
      questionId: question.id
    }
  end

  it_behaves_like 'student_authenticated_endpoint'

  context 'when logged in as student' do
    before(:each) do
      allow_any_instance_of(Queries::BaseQuery)
        .to receive(:current_student).and_return(student)

      allow(Translate).to receive(:new).and_return(
        instance_double('Translate', translate: 'hola')
      )
    end
    it 'translates the question' do
      res = QuizUsServerSchema.execute(query_string, variables: variables)
                              .to_h['data']['translatedQuestion']

      expect(res).to eq(
        'questionOptions' => nil,
        'questionText' => question.question_text,
        'translatedQuestionText' => 'hola'
      )
    end
  end
end
