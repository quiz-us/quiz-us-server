# frozen_string_literal: true

module Queries
  module Students
    class PersonalAssignment < BaseQuery
      description 'Displays next batch of cards that should appear in personal deck'

      type Types::AssignmentType, null: false

      def resolve
        personal_deck = current_student.personal_decks.first
        # get all of the student's cards in personal deck, ordered by
        # when the card is due:
        all_cards = personal_deck.cards
                                 .includes(
                                   :question,
                                   question: :question_options
                                 )
                                 .order(next_due: :asc)

        # get all of the student's responses in the last 24 hours:
        responses = Response.includes(:question)
                            .where(student_id: current_student.id)
                            .where(
                              'responses.created_at > ?',
                              Time.current - 1.day
                            )
        recently_responded_correctly = {}
        recently_responded_incorrectly = {}

        responses.each do |res|
          question = res.question
          if res.mc_correct || (res.self_grade && res.self_grade >= 4)
            # store all of the student's correct responses from last 24 hours:
            recently_responded_correctly[question.id] = true
          elsif recently_responded_incorrectly[question.id]
            # store all of the student's incorrect responses from last 24 hours:
            recently_responded_incorrectly[question.id] << res
          else
            recently_responded_incorrectly[question.id] = [res]
          end
        end

        questions = []
        responses = []
        all_cards.each do |card|
          q_id = card.question.id
          questions << card.question unless recently_responded_correctly[q_id]
          recently_responded_incorrectly[q_id]&.each do |incorrect_res|
            responses << incorrect_res
          end
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
          deck: deck,
          responses: responses
        }
      end
    end
  end
end
