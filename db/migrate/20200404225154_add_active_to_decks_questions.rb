# frozen_string_literal: true

class AddActiveToDecksQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :decks_questions, :active, :boolean, default: true, null: false, index: true
  end
end
