# frozen_string_literal: true

module Ilex
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

    def content
      @component.send :content
    end

    # This is overriding arbre::rails::rendering
    # It performs the same actions, but returns html_safe on a passed block
    #
    # Not 100% sure this is needed, but view_components won't render their
    # contents without it, when rendered in an arbre tree
    def render(*args)
      rendered = helpers.render(*args) do
        yield.html_safe if block_given?
      end
      case rendered
      when Arbre::Context
        current_arbre_element.add_child rendered
      else
        text_node rendered
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
