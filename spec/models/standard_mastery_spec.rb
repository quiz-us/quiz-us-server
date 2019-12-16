# frozen_string_literal: true

# == Schema Information
#
# Table name: standard_masteries
#
#  id           :bigint           not null, primary key
#  num_attempts :integer          default(0), not null
#  num_correct  :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  standard_id  :bigint           not null, indexed, indexed => [student_id]
#  student_id   :bigint           not null, indexed, indexed => [standard_id]
#

require 'rails_helper'

RSpec.describe StandardMastery, type: :model do
  let!(:standard_mastery) do
    create(:standard_mastery, num_correct: 1, num_attempts: 4)
  end
  describe 'associations' do
    it { should belong_to(:student) }
    it { should belong_to(:standard) }
  end

  describe 'validations' do
    it { should validate_presence_of(:student) }
    it { should validate_presence_of(:standard) }
    it { should validate_presence_of(:num_correct) }
    it { should validate_presence_of(:num_attempts) }
    it { should validate_uniqueness_of(:student_id).scoped_to(:standard_id) }
  end

  describe '#percent_correct' do
    it 'calculates the percentage of correct attempts' do
      expect(standard_mastery.percent_correct).to eq(25)
    end
  end
end
