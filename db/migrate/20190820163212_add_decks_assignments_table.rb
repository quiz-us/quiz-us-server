# frozen_string_literal: true

class AddDecksAssignmentsTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :decks, :release_date, :date
    change_column_null :decks, :teacher_id, true
    change_column_null :decks, :name, true

    create_table :assignments do |t|
      t.belongs_to :deck, null: false, foregn_key: true, index: true
      t.belongs_to :student, null: false, foregn_key: true, index: true
      t.datetime :due, index: true
      t.text :instructions
      t.timestamps
    end
  end
end
