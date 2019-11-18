# frozen_string_literal: true

# http://weblog.jamisbuck.org/2007/1/17/concerns-in-activerecord
module Callable
  extend ActiveSupport::Concern
  # this is for service objects to have a call method
  class_methods do
    def call(*args)
      new(*args).call
    end
  end
end
