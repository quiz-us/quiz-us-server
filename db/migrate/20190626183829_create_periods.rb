class CreatePeriods < ActiveRecord::Migration[5.0]
  def change
    create_table :periods do |t|
      t.string :name
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
