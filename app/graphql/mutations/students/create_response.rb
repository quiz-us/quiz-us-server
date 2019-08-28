# frozen_string_literal: true

module Mutations
  module Students
    class CreateResponse < BaseMutation
      graphql_name 'Create Response'
      description 'Creates a response'

      argument :question_id, ID, required: true
      argument :assignment_id, ID, required: false
      argument :question_option_id, ID, required: false
      argument :response_text, String, required: false
      argument :self_grade, Integer, required: false
      argument :question_type, String, required: true

      type Types::ResponseType

      def resolve(question_id:, assignment_id:, question_option_id:, response_text:, self_grade:, question_type:)
        response = current_student.responses.create!(
          question_id: question_id,
          assignment_id: assignment_id,
          question_option_id: question_option_id,
          response_text: response_text,
          self_grade: self_grade
        )
        # TODO: delegate following logic to an async job:
        personal_deck = current_student.personal_decks.first
        card = personal_deck.cards.find_by(question_id: question_id) ||
               personal_deck.cards.create!(question_id: question_id)

        case question_type
        when 'Multiple Choice'
          rating = QuestionOption.find(question_option_id).correct ? 4 : 1
        when 'Free Response'
          rating = self_grade.to_i
        else
          raise StandardError('That Question Type is not currently supported!')
        end
        CalculateDue.new(rating, card).call
        response
      end
    end
  end
end
