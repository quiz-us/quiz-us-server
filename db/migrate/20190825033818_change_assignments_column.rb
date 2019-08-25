# frozen_string_literal: true

class ChangeAssignmentsColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :assignments, :student_id, :bigint
    add_reference :assignments, :period, index: true, null: false
  end
end
