# frozen_string_literal: true

module Queries
  module Teachers
    class TagIndex < TeacherQuery
      description 'Display all tags'

      type [Types::TagType], null: false

      def resolve
        Tag.all
      end
    end
  end
end
