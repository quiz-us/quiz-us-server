# frozen_string_literal: true

class AddDefaultToNextDue < ActiveRecord::Migration[5.2]
  def up
    change_column_default :students_questions, :next_due, -> { 'CURRENT_TIMESTAMP' }
  end

  def down
    change_column_default :students_questions, :next_due, nil
  end
end
