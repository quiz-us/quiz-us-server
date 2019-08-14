# == Schema Information
#
# Table name: standards
#
#  id                 :integer          not null, primary key
#  standards_chart_id :integer
#  text               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Standard < ApplicationRecord
  belongs_to :standards_chart

  has_many :questions_standards,
    primary_key: :id,
    foreign_key: :standard_id,
    class_name: :QuestionsStandard

  has_many :questions,
    through: :questions_standards,
    source: :question
end
