# frozen_string_literal: true

class AddAssignmentIdToResponses < ActiveRecord::Migration[5.2]
  def change
    add_column :responses, :assignment_id, :integer, index: true
    add_column :responses, :question_id, :integer, index: true, null: false
    change_column_null :responses, :student_id, false
  end
end
