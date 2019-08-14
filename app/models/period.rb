# == Schema Information
#
# Table name: periods
#
#  id         :integer          not null, primary key
#  name       :string
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Period < ApplicationRecord
  belongs_to :course
end
