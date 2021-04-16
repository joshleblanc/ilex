# frozen_string_literal: true

module Ilex
  ##
  # Thin wrapper around a hash of component wardens
  # such that the default is always an instance of ComponentWarden
  class ComponentWardens
    def initialize(component)
      @wardens = Hash.new do |hash, key|
        hash[key] = ComponentWarden.new(component, key)
      end
    end

    def [](key)
      @wardens[key]
    end
  end
end
