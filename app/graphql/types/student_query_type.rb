module Types
  class StudentQueryType < BaseObject
    field :current_student, resolver: Queries::Students::CurrentStudent
  end
end
