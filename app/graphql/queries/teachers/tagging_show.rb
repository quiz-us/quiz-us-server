# frozen_string_literal: true

module Queries
  module Teachers
    class TaggingShow < TeacherQuery
      description 'Display one tagging entry on the joins table'

      argument :id, ID, required: true

      type Types::TaggingType, null: false

      def resolve(id:)
        Tagging.find(id)
      end
    end
  end
end
