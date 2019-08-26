# frozen_string_literal: true

class AddGradesToResponses < ActiveRecord::Migration[5.2]
  def change
    add_column :responses, :self_grade, :integer
    add_column :responses, :mc_correct, :boolean
  end
end
