class CreateQuestionOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :question_options do |t|
      t.references :question, foreign_key: true
      t.string :option_text
      t.boolean :correct

      t.timestamps
    end
  end
end
