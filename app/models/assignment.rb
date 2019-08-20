# frozen_string_literal: true

# == Schema Information
#
# Table name: assignments
#
#  id           :bigint           not null, primary key
#  deck_id      :bigint           not null
#  student_id   :bigint           not null
#  due          :datetime
#  instructions :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#


class Assignment < ApplicationRecord
  belongs_to :student
  belongs_to :deck
end
