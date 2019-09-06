# frozen_string_literal: true

module Queries
  module Students
    class PersonalAssignment < BaseQuery
      description 'Displays next batch of cards that should appear in personal deck'

      type Types::AssignmentType, null: false

      def resolve
        personal_deck = current_student.personal_decks.first
        all_cards = personal_deck.cards
                                 .includes(:question, question: :question_options)
                                 .order(next_due: :desc)

        responses = Response.includes(:question)
                            .where(student_id: current_student.id)
                            .where(
                              'responses.created_at > ?',
                              Time.current - 10.minutes
                            )
        recently_responded = {}
        responses.each do |res|
          question = res.question
          recently_responded[question.id] = true
        end

        questions = []
        all_cards.each do |card|
          questions << card.question unless recently_responded[card.question.id]
          break if questions.length >= 10
        end
        deck = {
          id: personal_deck.id,
          name: personal_deck.name,
          description: personal_deck.description,
          questions: questions
        }
        {
          instructions: 'Finish all cards in this session!',
          deck: deck
        }
      end
    end
  end
end