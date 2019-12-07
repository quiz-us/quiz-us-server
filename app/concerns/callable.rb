# frozen_string_literal: true

# https://medium.com/selleo/essential-rubyonrails-patterns-part-1-service-objects-1af9f9573ca1
module Callable
  extend ActiveSupport::Concern

  class_methods do
    def call(*args)
      new(*args).call
    end
  end
end
