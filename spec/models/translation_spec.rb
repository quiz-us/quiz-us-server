# == Schema Information
#
# Table name: translations
#
#  id          :bigint           not null, primary key
#  count       :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint           not null, indexed
#  student_id  :bigint           not null, indexed
#

require 'rails_helper'

RSpec.describe Translation, type: :model do
  describe 'associations' do
    it { should belong_to(:student) }
    it { should belong_to(:question) }
  end
end
