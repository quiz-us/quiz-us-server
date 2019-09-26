# frozen_string_literal: true

# == Schema Information
#
# Table name: assignments
#
#  id           :bigint           not null, primary key
#  deck_id      :bigint           not null
#  due          :datetime
#  instructions :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  period_id    :bigint           not null
#


require 'rails_helper'

RSpec.describe Assignment, type: :model do
  describe 'associations' do
    it { should belong_to(:period) }
    it { should belong_to(:deck) }
    it do
      should have_many(:responses).order(:created_at)
                                  .dependent(:destroy)
                                  .inverse_of(:assignment)
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:deck) }
    it { should validate_presence_of(:period) }
  end
end
