# frozen_string_literal: true

class AddStandardsChartCategoriesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :standards_categories do |t|
      t.string :title, null: false
      t.text :description
      t.integer :standards_chart_id, null: false, index: true
      t.timestamps
    end

    change_table :standards do |t|
      t.integer :standards_category_id, null: false, index: true
      t.rename :text, :description
      t.string :title
      t.string :meta
    end
  end
end
