# frozen_string_literal: true

# == Schema Information
#
# Table name: teachers
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  jti                    :string           not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#


FactoryBot.define do
  factory :teacher do
    password { SecureRandom.hex(10) }
    email { Faker::Internet.email }
  end
end
