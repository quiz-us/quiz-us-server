# frozen_string_literal: true

module Queries
  module Teachers
    class TagShow < TeacherQuery
      description 'Display one tag'

      argument :id, ID, required: true

      type Types::TagType, null: false

      def resolve(id:)
        Tag.find(id)
      end
    end
  end
end
