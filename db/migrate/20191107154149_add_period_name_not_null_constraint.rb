# frozen_string_literal: true

class AddPeriodNameNotNullConstraint < ActiveRecord::Migration[5.2]
  def change
    change_column_null :periods, :name, false
  end
end
