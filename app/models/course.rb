class Course < ApplicationRecord
  belongs_to :teacher
  belongs_to :standards_chart
end
