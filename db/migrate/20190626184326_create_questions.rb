class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.text :question_text
      t.string :type

      t.timestamps
    end
  end
end
