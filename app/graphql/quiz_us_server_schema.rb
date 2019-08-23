# frozen_string_literal: true

class QuizUsServerSchema < GraphQL::Schema
  #########################################
  # ERROR HANDLING:
  rescue_from(ActiveRecord::RecordNotFound) do
    Graphql::ExecutionError.new('Not Found')
  end

  rescue_from(ActiveRecord::RecordInvalid) do |exception|
    GraphQL::ExecutionError.new(exception.record.errors.full_messages.join("\n"))
  end

  #########################################
  # Definition of QueryType and MutationType
  query(Types::QueryType)
  mutation(Types::MutationType)
end
