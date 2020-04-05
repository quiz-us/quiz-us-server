# frozen_string_literal: true

class AddOnboardedToTeachers < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :onboarded, :boolean, default: false, null: false
  end
end
