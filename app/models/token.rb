# frozen_string_literal: true

# == Schema Information
#
# Table name: tokens
#
#  id         :bigint           not null, primary key
#  expired    :boolean          default(FALSE)
#  value      :string           not null, indexed
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  student_id :bigint           not null, indexed
#

class Token < ApplicationRecord
  validates :value, :student_id, presence: true
  after_initialize :generate_value

  belongs_to :student

  def self.authenticate(token)
    found_token = Token.find_by(value: token)

    return nil unless found_token

    return nil if found_token.expired?

    found_token.student
  end

  def expired?
    return true if expired

    is_expired = Time.current.utc > (created_at + 24.hours)
    expire! if is_expired
    is_expired
  end

  def expire!
    update(expired: true)
  end

  def generate_value
    self.value = SecureRandom.hex(16)
  end
end
