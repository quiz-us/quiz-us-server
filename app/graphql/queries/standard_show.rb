module Queries
  class StandardShow < BaseQuery
    description 'Display one standard'

    argument :id, ID, required: true
    
    type Types::StandardType, null: false

    def resolve(id: )
      Standard.includes(:questions).find(id)
    end
  end
end