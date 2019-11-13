# frozen_string_literal: true

# == Schema Information
#
# Table name: periods
#
#  id         :integer          not null, primary key
#  name       :string           not null, indexed => [course_id]
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :integer          indexed, indexed => [name]
#

require 'rails_helper'

RSpec.describe Period, type: :model do
  it { should delegate_method(:standards_chart).to(:course) }
  describe 'validations' do
    let!(:period) { create(:period) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:course_id) }
  end
  describe 'associations' do
    it { should belong_to(:course) }
    it { should have_many(:students).through(:enrollments) }
    it { should have_many(:enrollments).dependent(:destroy) }
    it { should have_many(:assignments).dependent(:destroy) }
  end
end
