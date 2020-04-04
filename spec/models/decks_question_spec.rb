# frozen_string_literal: true

# == Schema Information
#
# Table name: decks_questions
#
#  id                      :bigint           not null, primary key
#  active                  :boolean          default(TRUE), not null
#  e_factor                :float            default(2.5)
#  next_due                :datetime
#  num_consecutive_correct :integer          default(0)
#  total_attempts          :integer          default(0)
#  total_correct           :integer          default(0)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  deck_id                 :integer          not null, indexed => [question_id], indexed => [question_id], indexed => [question_id]
#  question_id             :integer          not null, indexed => [deck_id], indexed => [deck_id], indexed => [deck_id]
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
