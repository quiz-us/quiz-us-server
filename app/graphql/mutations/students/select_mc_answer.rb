# frozen_string_literal: true

module Mutations
  module Students
    class SelectMcAnswer < StudentMutation
      graphql_name 'Select a multiple choice answer'
      description 'Select multiple choice answer'

      argument :response_id, ID, required: true
      argument :question_option_id, ID, required: true

      type Types::ResponseType

      def resolve(response_id:, question_option_id:)
        response = Response.find(response_id)
        response.update!(
          question_option_id: question_option_id,
          mc_correct: QuestionOption.find(question_option_id).correct
        )
        # TODO: delegate following logic to an async job:
        personal_deck = current_student.personal_decks.first
        question_id = response.question_id
        personal_deck.cards.find_or_create_by!(question_id: question_id)

        rating = response.mc_correct ? Response::MIN_CORRECT_SCORE : 1
        response.calculate_mastery!(current_student)
        CalculateDue.call(rating, current_student.id, question_id)
        correct_answer_choice_id = response
                                   .question.question_options.find(&:correct).id
        {
          id: response.id,
          question_option_id: response.question_option_id,
          mc_correct: response.mc_correct,
          correct_question_option_id: correct_answer_choice_id
        }
      end
    end
  end
end
