# frozen_string_literal: true

module Ilex

  ##
  # InlineRender provides a `render` dsl to your components
  # which will render any arbre tree within.
  #
  # It will also convert snake case component names to component instances
  # for example, this would be equivalent to `ButtonComponent.new(label: "Test")`
  #
  # ```ruby
  # render do
  #   div do
  #     button label: "Test"
  #   end
  # end
  # ```
  module Component
    include Arbre::HTML

    def render(*args, &blk)
      define_method :call do
        ctx = Context.new(self)
        ctx.instance_eval(&blk).to_s
      end
    end

    def find_component(name, base_module = nil)
      target = if base_module
        base_module
      else
        self
      end

      if target.const_defined?(name)
        target.const_get(name)
      else
        if target.superclass.respond_to?(:find_component)
          target.superclass.find_component(name)
        else
          adjusted_name = name.chomp("Component").underscore
          raise(NameError, "undefined local variable or method `#{adjusted_name}` for #{self}")
        end

      end
    end
  end
end
