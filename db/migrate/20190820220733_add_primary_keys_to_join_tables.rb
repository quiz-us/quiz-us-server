# frozen_string_literal: true

class AddPrimaryKeysToJoinTables < ActiveRecord::Migration[5.2]
  def change
    add_column :decks_questions, :id, :primary_key, auto_increment: true
    add_column :enrollments, :id, :primary_key, auto_increment: true
    add_column :questions_standards, :id, :primary_key, auto_increment: true
  end
end
