# == Schema Information
#
# Table name: students
#
#  id                     :integer          not null, primary key
#  email                  :string           not null
#  first_name             :string           not null
#  last_name              :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  jti                    :string           not null
#  qr_code                :string           default(""), not null
#


FactoryBot.define do
  factory :student do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { SecureRandom.hex(10) }
    email { Faker::Internet.email }
  end
end
