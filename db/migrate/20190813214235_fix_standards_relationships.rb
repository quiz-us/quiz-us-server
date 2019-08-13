# frozen_string_literal: true

class FixStandardsRelationships < ActiveRecord::Migration[5.0]
  def change
    # enforce a clear hiearchy between standards_chart => standards_category => standards:
    remove_column :standards, :standards_chart_id, :integer
    add_foreign_key :standards, :standards_categories
    add_foreign_key :standards_categories, :standards_charts

    add_index :standards, :title
    add_index :standards, :standards_category_id
    add_index :standards_categories, :title

    change_column_null :standards, :title, false
    change_column_null :standards, :description, false
  end
end
