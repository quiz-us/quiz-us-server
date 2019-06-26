class CreateJoinTableQuestionStandard < ActiveRecord::Migration[5.0]
  def change
    create_join_table :questions, :standards do |t|
      t.index [:question_id, :standard_id]
      t.index [:standard_id, :question_id]
    end
  end
end
