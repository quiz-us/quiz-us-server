# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/teacher_authenticated_endpoint.rb'

describe 'Queries::Teachers::StudentAssignmentResults' do
  let(:teacher) { create(:teacher) }
  let(:student) { create(:student) }
  let(:course) { create(:course, teacher: teacher) }
  let(:period) { create(:period, course: course) }
  let(:deck) { create(:deck) }
  let(:assignment) { create(:assignment, period: period, deck: deck) }
  let(:query_string) do
    <<-GRAPHQL
      query($studentId: ID!, $assignmentId: ID!) {
        studentAssignmentResults(
          studentId: $studentId
          assignmentId: $assignmentId
        ) {
          id
          richText
          questionType
          responses {
            createdAt
            id
            questionOption {
              richText
            }
            responseText
            mcCorrect
            selfGrade
          }
        }
      }
    GRAPHQL
  end
  let(:variables) do
    {
      assignmentId: assignment.id,
      studentId: student.id
    }
  end
  it_behaves_like 'teacher_authenticated_endpoint'

  context 'when logged in as teacher' do
    let(:question_1) { create(:question) }
    let(:question_2) { create(:question) }
    let(:question_3) { create(:question) }
    before(:each) do
      allow_any_instance_of(Queries::BaseQuery)
        .to receive(:current_teacher).and_return(teacher)

      create(:decks_question, question: question_1, deck: deck)
    end

    it 'returns an array of questions in that assignment' do
      res = QuizUsServerSchema.execute(query_string, variables: variables)
                              .to_h['data']['studentAssignmentResults']
      expect(res.length).to eq(1)
      expect(res[0]).to include(
        'id' => question_1.id.to_s,
        'questionType' => question_1.question_type,
        'richText' => question_1.rich_text,
        'responses' => question_1.responses
      )
    end

    it 'sorts questions by number of responses in descending order' do
      create(:decks_question, question: question_2, deck: deck)
      create(:decks_question, question: question_3, deck: deck)
      create(:response,
             student: student,
             question: question_2,
             assignment: assignment)
      create(:response,
             student: student,
             question: question_2,
             assignment: assignment)
      create(:response,
             student: student,
             question: question_1,
             assignment: assignment)

      res = QuizUsServerSchema.execute(query_string, variables: variables)
                              .to_h['data']['studentAssignmentResults']
      expect(res.length).to eq(3)
      expect(res[0]).to include(
        'id' => question_2.id.to_s,
        'questionType' => question_2.question_type,
        'richText' => question_2.rich_text
      )
      expect(res[0]['responses'].length).to eq(2)
      expect(res[2]['id'].to_i).to eq(question_3.id)
    end
  end
end
