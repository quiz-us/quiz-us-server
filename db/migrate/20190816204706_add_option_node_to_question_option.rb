# frozen_string_literal: true

class AddOptionNodeToQuestionOption < ActiveRecord::Migration[5.0]
  def change
    add_column :question_options, :option_node, :string, null: false, default: ''
  end
end
