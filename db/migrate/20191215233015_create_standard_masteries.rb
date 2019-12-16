# frozen_string_literal: true

class CreateStandardMasteries < ActiveRecord::Migration[5.2]
  def change
    create_table :standard_masteries do |t|
      t.belongs_to :student, null: false, foreign_key: true, index: true
      t.belongs_to :standard, null: false, foreign_key: true, index: true
      t.integer :num_attempts, null: false, default: 0
      t.integer :num_correct, null: false, default: 0
      t.timestamps
    end
  end
end
