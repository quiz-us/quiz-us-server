# frozen_string_literal: true

module Mutations
  module Students
    class RateFrAnswer < StudentMutation
      graphql_name 'Rate Free Response Answer'
      description 'Student self-assesses their free response answer'

      argument :response_id, ID, required: true
      argument :self_grade, Integer, required: true

      type Types::ResponseType

      def resolve(response_id:, self_grade:)
        response = Response.find(response_id)
        response.update!(
          self_grade: self_grade
        )
        # TODO: delegate following logic to an async job:
        personal_deck = current_student.personal_decks.first
        question_id = response.question_id
        personal_deck.cards.find_or_create_by!(question_id: question_id)

        rating = self_grade
        response.calculate_mastery!(current_student)
        CalculateDue.call(rating, current_student.id, question_id)
        response
      end
    end
  end
end
