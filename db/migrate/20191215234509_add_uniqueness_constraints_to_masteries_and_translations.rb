class AddUniquenessConstraintsToMasteriesAndTranslations < ActiveRecord::Migration[5.2]
  def change
    add_index :translations, %i[student_id question_id], unique: true
    add_index :standard_masteries, %i[student_id standard_id], unique: true
  end
end
