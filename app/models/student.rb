# == Schema Information
#
# Table name: students
#
#  id         :integer          not null, primary key
#  email      :string
#  password   :string
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Student < ApplicationRecord
end
