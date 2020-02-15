class CreateStudentsQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :students_questions do |t|
      t.integer 'num_consecutive_correct', default: 0, null: false
      t.integer 'total_correct', default: 0, null: false
      t.integer 'total_attempts', default: 0, null: false
      t.float 'e_factor', default: 2.5, null: false
      t.datetime 'next_due', null: false, index: true
      t.belongs_to :student, null: false, foreign_key: true, index: true
      t.belongs_to :question, null: false, foreign_key: true, index: true
      t.timestamps
    end
  end
end
