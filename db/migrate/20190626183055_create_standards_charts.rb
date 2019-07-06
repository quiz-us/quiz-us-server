class CreateStandardsCharts < ActiveRecord::Migration[5.0]
  def change
    create_table :standards_charts do |t|
      t.string :title

      t.timestamps
    end
  end
end
