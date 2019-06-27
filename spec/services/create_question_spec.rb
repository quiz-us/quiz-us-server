# frozen_string_literal: true

require 'rails_helper'

describe CreateQuestion do
  it 'creates a question' do
    # temporarily skip this example since Question model has not been 
    # implemented yet on this branch:
    skip
    result = CreateQuestion.call({
      question: 'What does the fox say?'
    })
    expect(Question.last.question).to eq(result[:question].question_text)
  end
  it 'creates each object within a transaction'
end
