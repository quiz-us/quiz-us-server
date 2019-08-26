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
      argument :question_type, Integer, required: false

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
        card = personal_deck.decks_questions.find_by(question_id: question_id) ||
               personal_deck.decks_questions.create!(question_id: question_id)
        if question_type == 'Multiple Choice'
          # determine when they need to see the question again
          # either add it to personal deck with newly calculated date
          # or find existing deck_questions and set the next review date to
          # newly calculated date
        elsif question_type == 'Free Response'
          # handle accordingly
          CalculateDue.new(self_grade.to_i, card).call
        end
        response
      end
    end
  end
end
