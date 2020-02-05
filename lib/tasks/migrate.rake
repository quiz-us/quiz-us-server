# frozen_string_literal: true

namespace :migrate do
  # WARNING: This rake task is NOT idempotent and it should be a ONE TIME rake
  # task to create standard_masteries records from student responses.
  task card_performance: :environment do
    p 'Migrating card performance from decks_questions to students_questions'
    # Querying for next_due.not nil to filter out decks_questions that are part
    # of a teacher's deck:
    decks_questions = DecksQuestion.where.not(next_due: nil)
    p "Migrating #{decks_questions.count} decks_questions to students_questions..."

    ActiveRecord::Base.transaction do
      decks_questions.each do |dq|
        if dq.deck.owner_type != 'Student'
          p 'Skipping decks_questions because it belongs to teacher'
          next
        end
        student = dq.deck.owner
        question_id = dq.question_id
        students_question = StudentsQuestion.find_or_create_by(
          student: student,
          question_id: question_id
        )
        students_question.update!(
          e_factor: dq.e_factor,
          next_due: dq.next_due,
          num_consecutive_correct: dq.num_consecutive_correct,
          total_attempts: dq.total_attempts,
          total_correct: dq.total_correct
        )
        print '.'
      end
    end

    p 'Done migrating card performances!'
  end
end
