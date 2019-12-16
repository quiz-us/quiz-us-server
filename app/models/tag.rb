# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string           indexed
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  validates :name, uniqueness: true

  has_many :taggings, dependent: :destroy
  has_many :questions,
           through: :taggings,
           source: :question
end
