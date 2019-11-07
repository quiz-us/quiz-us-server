# == Schema Information
#
# Table name: students
#
#  id                     :integer          not null, primary key
#  email                  :string           not null, indexed
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  jti                    :string           not null, indexed
#  last_name              :string           not null
#  qr_code                :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string           indexed
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#


FactoryBot.define do
  factory :student do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { SecureRandom.hex(10) }
    email { Faker::Internet.email }
  end
end
