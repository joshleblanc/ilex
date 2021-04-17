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
      @input = string.to_s

      @collection = @input.end_with? "_collection"
      @nested = @input.include? "__"

      process_input!(@input)
    end

    def collection?
      @collection
    end

    def nested?
      @nested
    end

    def component_name
      "#{@input}_component".camelize
    end

    def component_class
      @component_class ||= @component.class.find_component(component_name, @base_module)
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

    private

    def process_input!(input)
      @input.chomp! "_collection"
      @input.chomp! "_component"

      if nested?
        parts = @input.split("__")
        @input = parts.pop

        @base_module = parts.map(&:camelize).join("::").constantize
      end
    end
  end
end
