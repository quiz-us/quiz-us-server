class AddQuestionNodeToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :question_node, :string, null: false
  end
end
