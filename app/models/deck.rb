# frozen_string_literal: true

# == Schema Information
#
# Table name: decks
#
#  id          :integer          not null, primary key
#  description :text
#  name        :string
#  owner_type  :string           indexed => [owner_id]
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :bigint           indexed => [owner_type]
#

class Deck < ApplicationRecord
  belongs_to :owner, polymorphic: true

  has_many :cards, class_name: 'DecksQuestion', dependent: :destroy
  has_many :questions, through: :cards
  has_many :assignments, dependent: :destroy

  validates :name, uniqueness: { scope: %i[owner_id owner_type] }
end
