# frozen_string_literal: true

# == Schema Information
#
# Table name: students_questions
#
#  id                      :bigint           not null, primary key
#  e_factor                :float            default(2.5), not null
#  next_due                :datetime         not null, indexed
#  num_consecutive_correct :integer          default(0), not null
#  total_attempts          :integer          default(0), not null
#  total_correct           :integer          default(0), not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  question_id             :bigint           not null, indexed
#  student_id              :bigint           not null, indexed
#

require 'rails_helper'

RSpec.describe StudentsQuestion, type: :model do
  describe 'associations' do
    it { should belong_to(:student) }
    it { should belong_to(:question) }
  end

  describe 'validations' do
    it { should validate_presence_of(:student) }
    it { should validate_presence_of(:question) }
    it { should validate_presence_of(:e_factor) }
    it { should validate_presence_of(:next_due) }
    it { should validate_presence_of(:num_consecutive_correct) }
    it { should validate_presence_of(:total_attempts) }
    it { should validate_presence_of(:total_correct) }
  end
end
