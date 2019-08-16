module Mutations
  # This class is used as a parent for all mutations, and it is the place to have common utilities 
  class BaseMutation < GraphQL::Schema::Mutation
    include Authenticable
    # TODO is the following line neccesary?
    null false
  end
end
