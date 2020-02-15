# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculateDue do
  let(:student) { create(:student) }
  let(:question) { create(:question) }
  let(:incorrect_score) { Response::MIN_CORRECT_SCORE - 1 }
  let(:correct_score) { Response::MIN_CORRECT_SCORE }

  context 'when the student sees the question for the first time' do
    context 'when student misses the question' do
      it 'correctly calculates the fields' do
        result = CalculateDue.call(incorrect_score, student.id, question.id)
        expect(result[:total_correct]).to eq(0)
        expect(result[:num_consecutive_correct]).to eq(0)
        expect(result[:total_attempts]).to eq(1)
        # 2.5 is the starting e_factor:
        expect(result[:e_factor]).to be < 2.5
        expect(result[:next_due]).to be_within(10.seconds).of(Time.zone.now)
      end
    end

    context 'when student answers the question correctly' do
      it 'correctly calculates the fields' do
        result = CalculateDue.call(correct_score, student.id, question.id)
        expect(result[:total_correct]).to eq(1)
        expect(result[:num_consecutive_correct]).to eq(1)
        expect(result[:total_attempts]).to eq(1)
        # 2.5 is the starting e_factor:
        expect(result[:e_factor]).to eq(2.5)
        expect(result[:next_due]).to be_within(10.seconds).of(1.day.from_now)
      end
    end
  end

  context 'when the student has seen the question before' do
    let(:performance) do
      create(
        :students_question,
        num_consecutive_correct: 5,
        next_due: Time.zone.now,
        total_attempts: 5,
        total_correct: 5,
        e_factor: 3
      )
    end
    context 'when student misses the question' do
      it 'correctly calculates the fields' do
        result = CalculateDue.call(
          incorrect_score,
          performance.student_id,
          performance.question_id
        )
        expect(result[:total_correct]).to eq(5)
        expect(result[:num_consecutive_correct]).to eq(0)
        expect(result[:total_attempts]).to eq(6)
        # e_factor when student answered 5 times in a row (score of 5), but then
        # misses the 6th attempt:
        expect(result[:e_factor]).to eq(2.86)
        expect(result[:next_due]).to be_within(10.seconds).of(Time.zone.now)
      end
    end

    context 'when student answers the question correctly' do
      it 'correctly calculates the fields' do
        result = CalculateDue.call(
          correct_score + 1,
          performance.student_id,
          performance.question_id
        )
        expect(result[:total_correct]).to eq(6)
        expect(result[:num_consecutive_correct]).to eq(6)
        expect(result[:total_attempts]).to eq(6)
        # e_factor when student answered 5 times in a row (score of 5), but then
        # misses the 6th attempt:
        expect(result[:e_factor].round(1)).to eq(3.1)
        expect(result[:next_due]).to be_within(10.seconds).of(179.days.from_now)
      end
    end
  end
end
