# frozen_string_literal: true

class AddCompositeUniquenessIndexToJoinTables < ActiveRecord::Migration[5.2]
  def change
    add_index :decks_questions, %i[deck_id question_id], unique: true, name: 'by_deck_and_question'
    add_index :enrollments, %i[period_id student_id], unique: true, name: 'by_period_and_student'
    add_index :questions_standards, %i[question_id standard_id], unique: true, name: 'by_question_and_standard'
    add_index :assignments, %i[deck_id student_id], unique: true, name: 'by_deck_and_student'
    add_index :taggings, %i[tag_id question_id], unique: true, name: 'by_tag_and_question'
  end
end
