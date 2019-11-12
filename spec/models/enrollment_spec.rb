# frozen_string_literal: true

# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint           not null, primary key
#  period_id  :integer          not null, indexed => [student_id], indexed => [student_id], indexed => [student_id]
#  student_id :integer          not null, indexed => [period_id], indexed => [period_id], indexed => [period_id]
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
      should validate_uniqueness_of(:student).scoped_to(:period_id)
                                             .with_message(
                                               'is already in this class.'
                                             )
    end
    it { should validate_presence_of(:student) }
    it { should validate_presence_of(:period) }
  end
end
