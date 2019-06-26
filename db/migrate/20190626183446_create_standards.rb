class CreateStandards < ActiveRecord::Migration[5.0]
  def change
    create_table :standards do |t|
      t.references :standards_chart, foreign_key: true
      t.string :text

      t.timestamps
    end
  end
end
