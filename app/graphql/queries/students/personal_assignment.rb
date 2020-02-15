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
            INNER JOIN students_questions
            ON students_questions.question_id = questions.id
            INNER JOIN decks
            ON decks.owner_id = students_questions.student_id
            AND decks.owner_type = 'Student'
          SQL
        ).where(
          'students_questions.next_due < ? AND decks.id = ?',
          Time.current,
          personal_deck.id
        ).order('students_questions.next_due' => :asc)

        current_question = questions.first
        current_response = Questions::FindOrCreateUnfinishedResponse.call(
          current_question.id,
          current_student.id
        )

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
