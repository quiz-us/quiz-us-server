# frozen_string_literal: true

class AddUniquenessConstraintToPeriodName < ActiveRecord::Migration[5.2]
  def change
    add_index :periods, %i[course_id name], unique: true
  end
end
