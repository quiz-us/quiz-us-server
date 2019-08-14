# == Schema Information
#
# Table name: courses
#
#  id                 :integer          not null, primary key
#  name               :string
#  teacher_id         :integer
#  standards_chart_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Course < ApplicationRecord
  belongs_to :teacher
  belongs_to :standards_chart
end
