# frozen_string_literal: true

class AddDefaultToNextDue < ActiveRecord::Migration[5.2]
  def change
    change_column :students_questions, :next_due, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
