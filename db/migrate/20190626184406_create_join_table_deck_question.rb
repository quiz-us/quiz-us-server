class CreateJoinTableDeckQuestion < ActiveRecord::Migration[5.0]
  def change
    create_join_table :decks, :questions do |t|
      t.index [:deck_id, :question_id]
      t.index [:question_id, :deck_id]
    end
  end
end
