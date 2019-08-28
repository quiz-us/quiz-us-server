# frozen_string_literal: true

# == Schema Information
#
# Table name: decks
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_type  :string
#  owner_id    :bigint
#

class Deck < ApplicationRecord
  belongs_to :owner, polymorphic: true

  has_many :cards, class_name: 'DecksQuestion', dependent: :destroy
  has_many :questions, through: :cards

  validates :name, uniqueness: { scope: %i[owner_id owner_type] }

  has_many :assignments, dependent: :destroy
end
