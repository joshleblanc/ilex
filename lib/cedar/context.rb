# frozen_string_literal: true

module Cedar
  ##
  # Inject a component's instance variables into arbre's default context
  # as well as provide implicit handling of snake-cased component names as
  # tags
  class Context < Arbre::Context

    def initialize(component)
      super({}, component)

      @component = component
      @component_wardens = ComponentWardens.new(@component)

      # Copy all of the instance variables from the component to the context,
      # so we have access to them when rendering
      @component.instance_variables.each do |iv|
        instance_variable_set(iv, @component.instance_variable_get(iv))
      end
    end

    def respond_to_missing?(method, include_all)
      @component.respond_to?(method) || @component_wardens[method].exists? || super
    end

    def method_missing(method, *args, &content_block)
      if @component.respond_to?(method)
        @component.send(method, *args, &content_block)
      elsif @component_wardens[method].exists?
        render @component_wardens[method].new(*args, &content_block)
      else
        super
      end
    end
  end
end
