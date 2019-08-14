module Queries
  class TagShow < BaseQuery
    description 'Display one tag'

    argument :id, ID, required: true
    
    type Types::TagType, null: false

    def resolve(id: )
      Tag.find(id)
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
