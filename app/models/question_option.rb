# == Schema Information
#
# Table name: question_options
#
#  id          :integer          not null, primary key
#  question_id :integer
#  option_text :string
#  correct     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  option_node :string           default(""), not null
#

class QuestionOption < ApplicationRecord
  belongs_to :question
end
