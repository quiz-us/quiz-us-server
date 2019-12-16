# frozen_string_literal: true

# == Schema Information
#
# Table name: translations
#
#  id          :bigint           not null, primary key
#  count       :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint           not null, indexed, indexed => [student_id]
#  student_id  :bigint           not null, indexed, indexed => [question_id]
#

require 'rails_helper'

RSpec.describe Translation, type: :model do
  describe 'associations' do
    it { should belong_to(:student) }
    it { should belong_to(:question) }
  end

  describe 'validations' do
    let!(:translation) { create(:translation) }
    it { should validate_presence_of(:student) }
    it { should validate_presence_of(:question) }
    it { should validate_presence_of(:count) }
    it { should validate_uniqueness_of(:student_id).scoped_to(:question_id) }
  end
end
