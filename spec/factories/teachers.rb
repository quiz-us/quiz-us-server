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


FactoryBot.define do
  factory :teacher do
    password { SecureRandom.hex(10) }
    email { Faker::Internet.email }
  end
end
