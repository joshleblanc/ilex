# frozen_string_literal: true

module Ilex
  ##
  # A ComponentWarden is responsible for locating potential components
  # given a snake_case representation of that component.
  #
  # If a component exists, the warden is also responsible for calling the correct
  # instantiation method, depending if the component is a collection or not
  class ComponentWarden
    def initialize(component, string)
      @component = component
      @raw_input = string

      @collection = @raw_input.end_with? "_collection"
      @input = @raw_input.to_s.chomp("_collection")
    end

    def collection?
      @collection
    end

    def component_name
      "#{@input}_component".camelize
    end

    def component_class
      @component_class ||= @component.class.find_component(component_name)
    end

    def exists?
      component_class.present?
    end

    def new(*args, &block)
      return nil unless exists?

      if collection?
        component_class.with_collection(*args, &block)
      else
        component_class.new(*args, &block)
      end
    end
  end
end
