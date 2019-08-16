# frozen_string_literal: true

module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    include Authenticable
    null false
  end
end
