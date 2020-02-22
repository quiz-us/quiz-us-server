# frozen_string_literal: true

module Mutations
  module Teachers
    class DeleteStandard < TeacherMutation
      graphql_name 'Delete Standard'
      description 'Delete Standard'

      argument :id, ID, required: true

      type Types::StandardType

      def resolve(id:)
        Standard.find(id).destroy!
      end
    end
  end
end
