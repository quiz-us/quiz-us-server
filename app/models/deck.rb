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

  has_many :decks_questions, dependent: :destroy
  has_many :questions, through: :decks_questions

  validates :name, uniqueness: { scope: %i[owner_id owner_type] }
end
