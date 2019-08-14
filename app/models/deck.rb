# == Schema Information
#
# Table name: decks
#
#  id           :integer          not null, primary key
#  release_date :date
#  name         :string
#  description  :text
#  teacher_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Deck < ApplicationRecord
  belongs_to :teacher
end
