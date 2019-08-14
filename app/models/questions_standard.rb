# == Schema Information
#
# Table name: questions_standards
#
#  question_id :integer          not null
#  standard_id :integer          not null
#

class QuestionsStandard < ApplicationRecord
  belongs_to :question,
    foreign_key: "question_id",
    class_name: :Question

  belongs_to :standard,
    foreign_key: "standard_id",
    class_name: :Standard
end
