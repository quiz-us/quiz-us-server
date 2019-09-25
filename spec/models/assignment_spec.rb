require 'rails_helper'

RSpec.describe Assignment, type: :model do
  describe 'associations' do
    it { should belong_to(:period) }
    it { should belong_to(:deck) }
    it { should have_many(:responses) }
  end

  describe 'validations' do
    it { should validate_presence_of(:deck) }
    it { should validate_presence_of(:period) }
  end
end
