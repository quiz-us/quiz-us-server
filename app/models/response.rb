class Response < ApplicationRecord
  belongs_to :student
  belongs_to :question_option
end
