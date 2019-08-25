# frozen_string_literal: true

# == Schema Information
#
# Table name: students
#
#  id                     :integer          not null, primary key
#  email                  :string           not null
#  first_name             :string
#  last_name              :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  jti                    :string           not null
#

class Student < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Tokenizable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :tokens, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :periods, through: :enrollments

  has_many :assignments, through: :periods
  has_many :decks, through: :assignments
end
