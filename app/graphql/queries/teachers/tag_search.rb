# frozen_string_literal: true

module Queries
  module Teachers
    class TagSearch < TeacherQuery
      description 'Search for tags'

      argument :string, String, required: false

      type [Types::TagType], null: true

      def resolve(string:)
        Tag.where('lower(name) LIKE ?', "%#{string.downcase}%")
      end
    end
  end
end
