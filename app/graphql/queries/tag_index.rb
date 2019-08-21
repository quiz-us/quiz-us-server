module Queries
  class TagIndex < BaseQuery
    description 'Display all tags'
    
    type [Types::TagType], null: false

    def resolve
      Tag.all
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
