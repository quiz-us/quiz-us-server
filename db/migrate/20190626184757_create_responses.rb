class CreateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      t.references :student, foreign_key: true
      t.references :question_option, foreign_key: true
      t.text :response_text

      t.timestamps
    end
  end
end
