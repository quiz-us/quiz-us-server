# frozen_string_literal: true

require 'rails_helper'
require './spec/helpers/student_authenticated_endpoint.rb'

describe 'Mutations::Students::CreateResponse' do
  let(:question) { create(:question) }
  let(:query_string) do
    <<-GRAPHQL
      mutation (
        $questionId: ID!
        $assignmentId: ID
        $questionOptionId: ID
        $responseText: String
        $selfGrade: Int
        $questionType: String!
      ){
        createResponse (
          questionId: $questionId
          assignmentId: $assignmentId
          questionOptionId: $questionOptionId
          responseText: $responseText
          selfGrade: $selfGrade
          questionType: $questionType
        ) {
          id
        }
      }
    GRAPHQL
  end
  let(:variables) do
    {
      questionId: question.id,
      responseText: Faker::Lorem.sentence,
      selfGrade: Faker::Number.between(from: 1, to: 5),
      questionType: 'Free Response'
    }
  end

  it_behaves_like 'student_authenticated_endpoint'
end
