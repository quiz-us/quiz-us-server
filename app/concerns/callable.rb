# frozen_string_literal: true

# https://medium.com/selleo/essential-rubyonrails-patterns-part-1-service-objects-1af9f9573ca1
module Callable
  extend ActiveSupport::Concern
  # this is for service objects to have a call method
  class_methods do
    def call(*args)
      new(*args).call
    end
  end
end
