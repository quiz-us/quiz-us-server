# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string           indexed
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :tag do
    name { Faker::Educator.subject }
  end
end
