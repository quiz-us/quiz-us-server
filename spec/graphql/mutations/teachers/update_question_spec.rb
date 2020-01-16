# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'
require './spec/helpers/rich_text.rb'

describe 'Mutations::Teachers::UpdateQuestion' do
  let!(:teacher) { create(:teacher) }
  let(:question) { create(:question) }
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
      richText: generate_rich_text('this is the new question'),
      questionPlaintext: 'this is the new question'
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
      let!(:question_option) { create(:question_option, question: question) }
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

    context 'when a new tag is passed in' do
      let(:original_tag) { create(:tag, name: 'original') }
      it 'updates the tags' do
        create(:tagging, tag: original_tag, question: question)
        expect(question.tags.first.name).to eq('original')
        QuizUsServerSchema.execute(
          query_string,
          variables: {
            id: question.id,
            tags: ['new tag']
          }
        )
        updated_question = Question.find(question.id)
        expect(updated_question.tags.first.name).to eq('new tag')
        expect(updated_question.tags.count).to eq(1)
      end
    end

    context 'when a new standard is passed in' do
      let(:original_standard) { create(:standard, title: 'Old Standard') }
      let!(:new_standard) { create(:standard, title: 'New Standard') }

      it 'updates the standards' do
        create(
          :questions_standard,
          standard: original_standard,
          question: question
        )
        expect(question.standards.first.title).to eq('Old Standard')
        QuizUsServerSchema.execute(
          query_string,
          variables: {
            id: question.id,
            standardId: new_standard.id
          }
        )
        updated_question = Question.find(question.id)
        expect(updated_question.standards.first.title).to eq('New Standard')
        expect(updated_question.standards.count).to eq(1)
      end
    end
  end
end
