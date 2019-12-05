# frozen_string_literal: true

# == Schema Information
#
# Table name: responses
#
#  id                 :integer          not null, primary key
#  mc_correct         :boolean          indexed
#  response_text      :text
#  self_grade         :integer          indexed
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  assignment_id      :integer
#  question_id        :integer          not null
#  question_option_id :integer          indexed
#  student_id         :integer          not null, indexed
#

require 'rails_helper'

RSpec.describe Response, type: :model do
  describe 'associations' do
    it { should belong_to(:student) }
    it { should belong_to(:question) }
    it { should belong_to(:question_option).optional }
    it { should belong_to(:assignment).optional }
    it { should have_many(:standards).through(:question) }
  end

  describe 'validations' do
    it { should validate_presence_of(:question) }
    it { should validate_presence_of(:student) }
  end

  describe 'scopes' do
    describe ':correct' do
      it 'should return all responses that are mc_correct true or self_grade >= 4' do
        create(:response, :multiple_choice_incorrect)
        create(:response, :multiple_choice_incorrect)
        create(:response, :multiple_choice_correct)
        create(:response, :free_response_correct)
        create(:response, :free_response_incorrect)
        expect(Response.correct.count).to eq(2)
      end
    end
  end

  describe '#correct' do
    let(:mc_incorrect) { create(:response, mc_correct: false) }
    let(:mc_correct) { create(:response, mc_correct: true) }
    it 'returns true if mc_correct is true' do
      expect(mc_incorrect.correct).to eq(false)
      expect(mc_correct.correct).to eq(true)
    end

    let(:passing_self_grade) { create(:response, self_grade: 4, mc_correct: nil) }
    let(:failing_self_grade) { create(:response, self_grade: 3, mc_correct: nil) }
    it 'returns true if self_grade is present and grader than or equal to 4' do
      expect(passing_self_grade.correct).to eq(true)
      expect(failing_self_grade.correct).to eq(false)
    end
  end
end
