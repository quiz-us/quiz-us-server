# frozen_string_literal: true

# == Schema Information
#
# Table name: standards_categories
#
#  id                 :integer          not null, primary key
#  title              :string           not null
#  description        :text
#  standards_chart_id :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe StandardsCategory, type: :model do
  describe 'associations' do
    it { should have_many(:standards).dependent(:destroy) }
    it { should belong_to(:standards_chart) }
  end
end
