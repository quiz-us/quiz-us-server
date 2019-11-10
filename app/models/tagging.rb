# == Schema Information
#
# Table name: taggings
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer          indexed => [tag_id]
#  tag_id      :integer          indexed => [question_id]
#

class Tagging < ApplicationRecord
  belongs_to :question
  belongs_to :tag
  validates :question_id, uniqueness: { scope: :tag_id }
end
