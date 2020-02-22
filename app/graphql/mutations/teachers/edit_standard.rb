# frozen_string_literal: true

module Mutations
  module Teachers
    class EditStandard < TeacherMutation
      graphql_name 'Edit Standard'
      description 'Edit Standard'

      argument :id, ID, required: true
      argument :title, String, required: false
      argument :description, String, required: false

      type Types::StandardType

      def resolve(id:, title:, description:)
        standard = Standard.find(id)
        standard.update!(
          title: title, description: description
        )
        standard
      end
    end
  end
end
