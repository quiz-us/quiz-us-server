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
  # We're allowing question options to be orphaned for analytics purposes.
  # For example, we want a record of answer choices that students have
  # submitted in the past, even if the teacher eventually deleted that answer
  # choice from a question:
  belongs_to :question, optional: true
end
