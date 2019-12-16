# frozen_string_literal: true

# == Schema Information
#
# Table name: tokens
#
#  id         :bigint           not null, primary key
#  expired    :boolean          default(FALSE)
#  value      :string           not null, indexed
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  student_id :bigint           not null, indexed
#

require 'rails_helper'

RSpec.describe Token, type: :model do
  describe 'associations' do
    it { should belong_to(:student) }
  end

  describe 'validations' do
    it { should validate_presence_of(:value) }
    it { should validate_presence_of(:student_id) }
  end
end
