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
      let!(:question_option_2) { create(:question_option, question: question) }
      it 'orphans old answer choices that no longer exist' do
        expect(
          Question.find(question.id).question_options.pluck(:id)
            .include?(question_option_2.id)
        ).to eq(true)

        QuizUsServerSchema.execute(
          query_string,
          variables: {
            id: question.id,
            questionOptions: [
              {
                id: question.question_options.first.id,
                richText: generate_rich_text('new question option'),
                optionText: 'new question option',
                correct: true
              }.to_json,
              {
                richText: generate_rich_text('new option that did not previously exist'),
                optionText: 'new option that did not previously exist',
                correct: false
              }.to_json
            ]
          }
        )

        expect(
          Question.find(question.id).question_options.pluck(:id)
            .include?(question_option_2.id)
        ).to eq(false)
      end

      it 'updates answer choices' do
        first_text = 'updated text'
        second_text = 'new option that did not previously exist'
        QuizUsServerSchema.execute(
          query_string,
          variables: {
            id: question.id,
            questionOptions: [
              {
                id: question.question_options.first.id,
                richText: generate_rich_text(first_text),
                optionText: first_text,
                correct: false
              }.to_json,
              {
                richText: generate_rich_text(second_text),
                optionText: second_text,
                correct: true
              }.to_json
            ]
          }
        )
        updated_options = Question.find(question.id).question_options
        first_option = updated_options.first
        second_option = updated_options.second
        expect(first_option.option_text).to eq(first_text)
        expect(first_option.rich_text).to eq(generate_rich_text(first_text))
        expect(first_option.correct).to eq(false)
        expect(second_option.option_text).to eq(second_text)
        expect(second_option.rich_text).to eq(generate_rich_text(second_text))
        expect(second_option.correct).to eq(true)
      end
    end

    it 'updates the tags'

    it 'updates the standards'
  end
end
