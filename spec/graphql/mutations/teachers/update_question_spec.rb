# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Mutations::Teachers::UpdateQuestion' do
  def generate_rich_text(text)
    {
      object: 'value',
      document: {
        object: 'document',
        data: {},
        nodes: [{
          object: 'block',
          type: 'line',
          data: {},
          nodes: [{ object: 'text', text: text, marks: [] }]
        }]
      }
    }.to_json
  end

  let!(:teacher) { create(:teacher) }
  let(:question) { create(:question) }
  let(:standard) { create(:standard) }
  let!(:questions_standard) do
    create(:questions_standard, question: question, standard: standard)
  end

  let!(:question_option) { create(:question_option, question: question) }
  let(:query_string) do
    <<~GRAPHQL
      mutation updateQuestion(
          $id: ID!
          $standardId: ID
          $tags: [String!]
          $richText: String
          $questionPlaintext: String
          $questionOptions: [String!]
        ) {
          updateQuestion(
            id: $id
            standardId: $standardId
            tags: $tags
            richText: $richText
            questionPlaintext: $questionPlaintext
            questionOptions: $questionOptions
          ) {
            id
            questionType
            standards {
              id
              title
            }
            questionText
            richText
            tags {
              id
              name
            }
            questionOptions {
              id
              correct
              optionText
              richText
            }
          }
        }
    GRAPHQL
  end
  let(:variables) do
    {
      id: question.id,
      standardId: question.standards.first.id,
      tags: %w[new tag],
      richText: generate_rich_text('this is the new question'),
      questionPlaintext: 'this is the new question',
      questionOptions: [
        {
          id: question.question_options.first.id,
          richText: generate_rich_text('new question option'),
          optionText: 'new question option',
          correct: true
        }.to_json
      ]
    }
  end

  it_behaves_like 'teacher_authenticated_endpoint'

  context 'when teacher is logged in' do
    before(:each) do
      allow_any_instance_of(Mutations::BaseMutation).to receive(:current_teacher)
        .and_return(teacher)
    end

    it 'updates a question' do
      result = QuizUsServerSchema.execute(
        query_string, variables: variables
      ).to_h['data']['updateQuestion']

      expect(result['questionText']).to eq('this is the new question')
      expect(result['richText']).to eq(
        generate_rich_text('this is the new question')
      )
      updated_question = Question.find(question.id)
      expect(updated_question.question_text).to eq('this is the new question')
    end

    context 'when updating the question options' do
      it 'orphans old answer choices that no longer exist'

      it 'updates answer choices'
    end

    it 'updates the tags'

    it 'updates the standards'
  end
end
