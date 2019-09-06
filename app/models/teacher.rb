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

class Teacher < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Tokenizable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :courses, dependent: :destroy
  has_many :standards_charts, through: :courses
  has_many :standards_categories, through: :standards_charts
  has_many :standards, through: :standards_categories
  has_many :decks, as: :owner, dependent: :destroy
  has_many :periods, through: :courses
  has_many :students, through: :periods
  has_many :assignments, through: :periods
  has_many :questions, through: :courses
end
