# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id                 :integer          not null, primary key
#  name               :string
#  teacher_id         :integer
#  standards_chart_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#


require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'associations' do
    it { should belong_to(:teacher) }
    it { should belong_to(:standards_chart) }
    it { should have_many(:standards) }
    it { should have_many(:questions_standards).through(:standards) }
    it { should have_many(:questions).through(:questions_standards) }
    it { should have_many(:periods) }
  end
end
