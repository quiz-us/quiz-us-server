# frozen_string_literal: true

module Mutations
  module Teachers
    class EditStandardsCategory < TeacherMutation
      graphql_name 'Edit Standards Category'
      description 'Edit Standards Category description'

      argument :id, ID, required: true
      argument :title, String, required: false
      argument :description, String, required: false

      type Types::StandardsCategoryType

      def resolve(id:, title:, description:)
        cat = StandardsCategory.find(id)
        cat.update!(
          title: title, description: description
        )
        cat
      end
    end
  end
end
