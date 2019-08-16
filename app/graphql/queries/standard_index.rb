# frozen_string_literal: true

module Queries
  class StandardIndex < BaseQuery
    description 'Display all standards'

    # argument :course_id, ID, required: true

    type [Types::StandardType], null: false

    def resolve
      teacher_signed_in?
      # @todo: in the future, if a teacher has more than one course, we would
      # need to add a course switching interface in the frontend and pass
      # up current_course with each request. For example:
      # current_teacher.courses.find(:id).standards
      current_teacher.courses.first.standards
    end
  end
end
