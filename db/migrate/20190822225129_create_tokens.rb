# frozen_string_literal: true

class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.belongs_to :student, null: false, index: true
      t.string :value, null: false, index: true
      t.boolean :expired, default: false
      t.timestamps
    end
  end
end
