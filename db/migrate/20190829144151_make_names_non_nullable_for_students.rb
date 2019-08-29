# frozen_string_literal: true

class MakeNamesNonNullableForStudents < ActiveRecord::Migration[5.2]
  def change
    change_column_null :students, :first_name, false
    change_column_null :students, :last_name, false
  end
end
