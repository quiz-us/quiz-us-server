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
#  rich_text   :jsonb
#

class QuestionOption < ApplicationRecord
  belongs_to :question
end
