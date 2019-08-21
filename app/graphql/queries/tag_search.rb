module Queries
  class TagSearch < BaseQuery
    description 'Search for tags'

    argument :string, String, required: false
    
    type [Types::TagType], null: true

    def resolve(string: )
      Tag.where("lower(name) LIKE ?", "%#{string.downcase}%")
    end
  end
end

# sample query
# {
#   tagSearch(string: "common") {
#     name
#   }
# }
