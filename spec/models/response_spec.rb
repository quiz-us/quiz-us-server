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
end
