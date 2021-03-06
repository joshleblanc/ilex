module Ilex
  class Engine < ::Rails::Engine

    config.to_prepare do
      ActionView::Base.prepend RailsExt::ActionView::Base
      Arbre::Element.prepend ArbreExt::Element
      Arbre::Element::BuilderMethods.prepend ArbreExt::Element::BuilderMethods
      Arbre::HTML::TextNode.prepend ArbreExt::HTML::TextNode
    end
  end
end
