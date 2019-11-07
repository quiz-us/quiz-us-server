# frozen_string_literal: true

# == Schema Information
#
# Table name: questions_standards
#
#  id          :bigint           not null, primary key
#  question_id :integer          not null, indexed => [standard_id], indexed => [standard_id], indexed => [standard_id]
#  standard_id :integer          not null, indexed => [question_id], indexed => [question_id], indexed => [question_id]
#

class QuestionsStandard < ApplicationRecord
  belongs_to :question,
             foreign_key: 'question_id',
             class_name: :Question

  belongs_to :standard,
             foreign_key: 'standard_id',
             class_name: :Standard

  validates :question_id, uniqueness: { scope: :standard_id }
end
