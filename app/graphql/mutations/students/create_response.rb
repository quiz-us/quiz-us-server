# frozen_string_literal: true

module Mutations
  module Students
    class CreateResponse < StudentMutation
      graphql_name 'Create Response'
      description 'Creates a response'

      argument :question_id, ID, required: true
      argument :assignment_id, ID, required: false
      argument :question_option_id, ID, required: false
      argument :response_text, String, required: false
      argument :self_grade, Integer, required: false
      argument :question_type, String, required: true

      type Types::ResponseType

      def resolve(
        question_id:,
        assignment_id: nil,
        question_option_id: nil,
        response_text: nil,
        self_grade: nil,
        question_type:
      )
        response = current_student.responses.create!(
          question_id: question_id,
          assignment_id: assignment_id,
          question_option_id: question_option_id,
          response_text: response_text,
          self_grade: self_grade,
          mc_correct: (
            question_type == 'Multiple Choice' ?
            QuestionOption.find(question_option_id).correct :
            nil
          )
        )
        # TODO: delegate following logic to an async job:
        personal_deck = current_student.personal_decks.first
        personal_deck.cards.find_or_create_by!(question_id: question_id)

        case question_type
        when 'Multiple Choice'
          rating = response.mc_correct ? Response::MIN_CORRECT_SCORE : 1
        when 'Free Response'
          rating = self_grade.to_i
        else
          raise StandardError('That Question Type is not currently supported!')
        end
        response.calculate_mastery!(current_student)
        CalculateDue.call(rating, current_student.id, question_id)
        response
      end
    end
  end
end
