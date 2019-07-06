class CreateDecks < ActiveRecord::Migration[5.0]
  def change
    create_table :decks do |t|
      t.date :release_date
      t.string :name
      t.text :description
      t.references :teacher, foreign_key: true

      t.timestamps
    end
  end
end
