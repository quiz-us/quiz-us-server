module Queries
  class TaggingShow < BaseQuery
    description 'Display one tagging entry on the joins table'

    argument :id, ID, required: true
    
    type Types::TaggingType, null: false

    def resolve(id: )
      Tagging.find(id)
    end
  end
end

# sample query
# query TagShow{
#   tag(id: 1) {
#     id,
#     name

#   } 
# }
