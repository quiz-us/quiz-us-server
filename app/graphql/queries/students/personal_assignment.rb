# frozen_string_literal: true

module Queries
  module Students
    class PersonalAssignment < StudentQuery
      description 'Displays next batch of cards that should appear in personal deck'

      type Types::AssignmentType, null: false

      def resolve
        personal_deck = current_student.personal_decks.first
        qids = personal_deck.cards.where(active: true).pluck(:question_id)
        student_questions = StudentsQuestion.where(
          student: current_student,
          question_id: qids
        ).where(
          'next_due < ?',
          Time.current
        ).order(next_due: :asc).pluck(:question_id)

        current_question = Question.find_by(id: student_questions.first)

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
          num_questions: student_questions.length,
          current_response: current_response
        }
      end
    end
  end
end
