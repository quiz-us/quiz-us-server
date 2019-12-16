# frozen_string_literal: true

module Queries
  module Teachers
    class StandardShow < TeacherQuery
      description 'Display one standard'

      argument :id, ID, required: true

      type Types::StandardType, null: false

      def resolve(id:)
        Standard.includes(:questions).find(id)
      end
    end
  end
end
