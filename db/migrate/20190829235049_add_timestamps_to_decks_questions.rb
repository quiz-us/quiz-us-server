class AddTimestampsToDecksQuestions < ActiveRecord::Migration[5.2]
  def up 
    change_table :decks_questions do |t|
      t.timestamps
    end
  end

  def down
    remove_column :decks_questions, :created_at
    remove_column :decks_questions, :updated_at
  end
end
