# frozen_string_literal: true

class AddMetaFieldsToDecksQuestions < ActiveRecord::Migration[5.2]
  def change
    # num consecutive correct
    # total stats history
    # e_factor
    # next_due
    add_column :decks_questions, :num_consecutive_correct, :integer, default: 0
    add_column :decks_questions, :total_correct, :integer, default: 0
    add_column :decks_questions, :total_attempts, :integer, default: 0
    add_column :decks_questions, :e_factor, :float, default: 2.5
    add_column :decks_questions, :next_due, :datetime
  end
end
