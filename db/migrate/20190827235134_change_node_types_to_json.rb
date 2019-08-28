# frozen_string_literal: true

class ChangeNodeTypesToJson < ActiveRecord::Migration[5.2]
  def change
    remove_column :questions, :rich_text, :string
    add_column :questions, :rich_text, :jsonb, default: {}

    remove_column :question_options, :rich_text, :string
    add_column :question_options, :rich_text, :jsonb, default: {}
  end
end
