# frozen_string_literal: true

module Queries
  module Students
    class PersonalAssignment < StudentQuery
      description 'Displays next batch of cards that should appear in personal deck'

      type Types::AssignmentType, null: false

      def resolve
        personal_deck = current_student.personal_decks.first

        questions = Question.joins(
          <<-SQL
            INNER JOIN decks_questions
            ON questions.id = decks_questions.question_id
            INNER JOIN students_questions
            ON students_questions.question_id = decks_questions.question_id
          SQL
        ).where(
          'students_questions.next_due < ? AND decks_questions.deck_id = ? AND decks_questions.active = ?',
          Time.current,
          personal_deck.id,
          true
        ).order('students_questions.next_due' => :asc)

        current_question = questions.first
        if current_question
          current_response = Questions::FindOrCreateUnfinishedResponse.call(
            current_question.id,
            current_student.id
          )
        end

        {
          id: personal_deck.id,
          instructions: 'These are all the cards that are due today.',
          deck: personal_deck,
          current_question: current_question,
          num_questions: questions.length,
          current_response: current_response
        }
      end
    end
  end
end
