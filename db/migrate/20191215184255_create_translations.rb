class CreateTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :translations do |t|
      t.belongs_to :student, null: false, foregn_key: true, index: true
      t.belongs_to :question, null: false, foregn_key: true, index: true
      t.integer :count, null: false, default: 0
      t.timestamps
    end
  end
end
