# frozen_string_literal: true

module Mutations
  module Teachers
    class DeleteStandardsCategory < TeacherMutation
      graphql_name 'Delete Standards Category'
      description 'Delete Standards Category'

      argument :id, ID, required: true

      type Types::StandardsCategoryType

      def resolve(id:)
        StandardsCategory.find(id).destroy!
      end
    end
  end
end
