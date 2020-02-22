# frozen_string_literal: true

module Mutations
  module Teachers
    class CreateStandard < TeacherMutation
      graphql_name 'Create Standard '
      description 'Create Standard'

      argument :category_id, ID, required: true
      argument :title, String, required: true
      argument :description, String, required: true

      type Types::StandardType

      def resolve(category_id:, title:, description:)
        StandardsCategory.find(category_id).standards.create!(
          title: title,
          description: description
        )
      end
    end
  end
end
