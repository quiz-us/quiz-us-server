# frozen_string_literal: true

# == Schema Information
#
# Table name: teachers
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null, indexed
#  encrypted_password     :string           default(""), not null
#  jti                    :string           not null, indexed
#  onboarded              :boolean          default(FALSE), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string           indexed
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'

RSpec.describe Teacher, type: :model do
  describe 'associations' do
    it { should have_many(:courses).dependent(:destroy) }
    it { should have_many(:standards_charts).through(:courses) }
    it { should have_many(:standards_categories).through(:standards_charts) }
    it { should have_many(:standards).through(:standards_categories) }
    it { should have_many(:periods).through(:courses) }
    it { should have_many(:students).through(:periods) }
    it { should have_many(:assignments).through(:periods) }
    it { should have_many(:questions).through(:courses) }
    it { should have_many(:decks).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:onboarded) }
  end
end
