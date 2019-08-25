# frozen_string_literal: true

class MakeDecksPolymorphic < ActiveRecord::Migration[5.2]
  def change
    remove_column :decks, :teacher_id, :integer
    add_reference :decks, :owner, polymorphic: true, index: true
  end
end
