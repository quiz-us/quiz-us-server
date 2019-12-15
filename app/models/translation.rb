# frozen_string_literal: true

# == Schema Information
#
# Table name: translations
#
#  id          :bigint           not null, primary key
#  count       :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint           not null, indexed
#  student_id  :bigint           not null, indexed
#

class Translation < ApplicationRecord
  belongs_to :student
  belongs_to :question
end
