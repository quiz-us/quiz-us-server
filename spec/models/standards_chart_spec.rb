# frozen_string_literal: true

# == Schema Information
#
# Table name: standards_charts
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe StandardsChart, type: :model do
  describe 'associations' do
    it { should have_many(:standards_categories).dependent(:destroy) }
    it { should have_many(:courses).dependent(:destroy) }
    it { should have_many(:standards).through(:standards_categories) }
  end
  describe 'validations' do
    it { should validate_presence_of(:title) }
  end
end
