# frozen_string_literal: true

module Cedar

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

    # The empty first arg is just to trick rubymine
    # when using `render` inside the arbre context
    def render(&blk)
      define_method :call do
        ctx = Context.new(self)
        ctx.instance_eval(&blk).to_s
      end
    end

    def find_component(name)
      if const_defined?(name)
        const_get(name)
      else
        raise(NameError, "with #{name} on receiver: #{self}", name, self) unless superclass.respond_to?(:find_component)

        superclass.find_component(name)
      end
    end
  end
end
