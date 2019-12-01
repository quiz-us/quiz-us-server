# frozen_string_literal: true

class AddIndicesToResponses < ActiveRecord::Migration[5.2]
  def change
    add_index :responses, :mc_correct
    add_index :responses, :self_grade
  end
end
