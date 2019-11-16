# == Schema Information
#
# Table name: question_options
#
#  id          :integer          not null, primary key
#  correct     :boolean
#  option_text :string
#  rich_text   :jsonb
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer          indexed
#

class QuestionOption < ApplicationRecord

  # add documentation
  belongs_to :question,
  optional: true
end
