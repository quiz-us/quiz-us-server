# frozen_string_literal: true

class AddCompositeUniquenessIndexToDecks < ActiveRecord::Migration[5.2]
  def change
    add_index :decks, %i[name teacher_id], unique: true, name: 'by_name_and_teacher_id'
  end
end
