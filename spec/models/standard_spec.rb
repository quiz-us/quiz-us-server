# frozen_string_literal: true

# == Schema Information
#
# Table name: standards
#
#  id                    :integer          not null, primary key
#  description           :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  standards_category_id :integer          not null
#  title                 :string           not null
#  meta                  :string
#

require 'rails_helper'

RSpec.describe Standard, type: :model do
  subject { create(:standard) }
  describe 'associations' do
    it { should belong_to(:standards_category) }
    it { should have_many(:questions_standards) }
    it { should have_many(:questions) }
  end

  describe 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:standards_category) }
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title).scoped_to(:standards_category_id) }
  end

  describe '#standards_chart' do
    it "should delegate #standards_chart to standards_category's association" do
      category = subject.standards_category
      expect(subject.standards_chart).to be(category.standards_chart)
    end
  end
end
