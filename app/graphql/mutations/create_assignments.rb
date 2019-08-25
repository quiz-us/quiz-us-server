# frozen_string_literal: true

module Mutations
  class CreateAssignments < BaseMutation
    graphql_name 'Create Assignment(s)'
    description 'Create Assignment(s)'

    # arguments passed to the `resolved` method
    argument :deck_id, ID, required: true
    argument :period_ids, [ID], required: true
    argument :due, Types::DateTimeType, required: true
    argument :instructions, String, required: false

    # return type from the mutation
    type [Types::AssignmentType]

    def resolve(deck_id:, period_ids:, due:, instructions:)
      assignments = []
      # TODO: prevent teacher from accidentally assigning the same deck twice:
      period_ids.each do |period_id|
        assignments << Assignment.create!(
          period: Period.find(period_id),
          deck: Deck.find(deck_id),
          due: due,
          instructions: instructions
        )
      end

      assignments
    end
  end
end
