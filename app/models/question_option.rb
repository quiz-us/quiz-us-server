# frozen_string_literal: true

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
  belongs_to :question
end
