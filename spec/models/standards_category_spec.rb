# frozen_string_literal: true

# == Schema Information
#
# Table name: standards_categories
#
#  id                 :integer          not null, primary key
#  description        :text
#  title              :string           not null, indexed => [standards_chart_id], indexed
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  standards_chart_id :integer          not null, indexed, indexed => [title]
#

require 'rails_helper'

RSpec.describe StandardsCategory, type: :model do
  subject { create(:standards_category) }
  describe 'associations' do
    it { should have_many(:standards).dependent(:destroy) }
    it { should belong_to(:standards_chart) }
  end

  describe 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:standards_chart) }
    it { should validate_presence_of(:title) }
    it do
      should validate_uniqueness_of(:title).scoped_to(:standards_chart_id)
    end
  end
end
