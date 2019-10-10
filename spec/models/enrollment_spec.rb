# frozen_string_literal: true

# == Schema Information
#
# Table name: enrollments
#
#  period_id  :integer          not null
#  student_id :integer          not null
#  id         :bigint           not null, primary key
#

require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  subject { create(:enrollment) }
  describe 'associations' do
    it { should belong_to(:period) }
    it { should belong_to(:student) }
  end

  describe 'validations' do
    it do
      should validate_uniqueness_of(:period_id).scoped_to(:student_id)
    end
    it { should validate_presence_of(:student) }
    it { should validate_presence_of(:period) }
  end
end