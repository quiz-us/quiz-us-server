# == Schema Information
#
# Table name: responses
#
#  id                 :integer          not null, primary key
#  student_id         :integer
#  question_option_id :integer
#  response_text      :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Response < ApplicationRecord
  belongs_to :student
  belongs_to :question_option
end
