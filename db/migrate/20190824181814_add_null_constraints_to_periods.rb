# frozen_string_literal: true

class AddNullConstraintsToPeriods < ActiveRecord::Migration[5.2]
  def change
    change_column_null :periods, :name, true
    change_column_null :periods, :course_id, true
  end
end
