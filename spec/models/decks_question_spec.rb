# frozen_string_literal: true

# == Schema Information
#
# Table name: decks_questions
#
#  deck_id                 :integer          not null
#  question_id             :integer          not null
#  id                      :bigint           not null, primary key
#  num_consecutive_correct :integer          default(0)
#  total_correct           :integer          default(0)
#  total_attempts          :integer          default(0)
#  e_factor                :float            default(2.5)
#  next_due                :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#


require 'rails_helper'

RSpec.describe DecksQuestion, type: :model do
  subject { create(:decks_question) }
  it { should delegate_method(:responses).to(:question) }
  describe 'associations' do
    it { should belong_to(:deck) }
    it { should belong_to(:question) }
  end

  describe 'validations' do
    it { should validate_presence_of(:deck) }
    it { should validate_presence_of(:question) }
    it do
      should validate_uniqueness_of(:question_id)
        .scoped_to(:deck_id)
    end
  end
end
