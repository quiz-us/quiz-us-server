# frozen_string_literal: true

# http://weblog.jamisbuck.org/2007/1/17/concerns-in-activerecord
module Callable
  extend ActiveSupport::Concern

  class_methods do
    def call(*args)
      new(*args).call
    end
  end
end
