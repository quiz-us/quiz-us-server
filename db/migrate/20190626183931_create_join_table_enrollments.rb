class CreateJoinTableEnrollments < ActiveRecord::Migration[5.0]
  def change
    create_join_table :periods, :students do |t|
      t.index [:period_id, :student_id]
      t.index [:student_id, :period_id]
    end
  end
end
