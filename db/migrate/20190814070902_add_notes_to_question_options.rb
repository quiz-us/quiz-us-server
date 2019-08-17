class AddNotesToQuestionOptions < ActiveRecord::Migration[5.0]
  def change
    add_column(:question_options, :option_node, :string)
  end
end
