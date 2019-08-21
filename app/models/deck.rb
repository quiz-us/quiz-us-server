# frozen_string_literal: true

# == Schema Information
#
# Table name: decks
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  teacher_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Deck < ApplicationRecord
  belongs_to :teacher
  has_many :decks_questions, dependent: :destroy
  has_many :questions, through: :decks_questions

  validates :name, uniqueness: { scope: :teacher_id }
end
