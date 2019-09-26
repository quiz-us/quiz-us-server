# frozen_string_literal: true

# == Schema Information
#
# Table name: decks
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_type  :string
#  owner_id    :bigint
#


require 'rails_helper'

RSpec.describe Deck, type: :model do
  describe 'associations' do
    it { should belong_to(:owner) }
    it do
      should have_many(:cards).class_name('DecksQuestion').dependent(:destroy)
    end
    it { should have_many(:questions).through(:cards) }
    it { should have_many(:assignments).dependent(:destroy) }
  end

  describe 'validations' do
    it do
      should validate_uniqueness_of(:name).scoped_to(:owner_id, :owner_type)
    end
  end
end
