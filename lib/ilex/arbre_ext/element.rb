module Ilex
  module ArbreExt
    module Element
      ruby2_keywords def method_missing(name, *args, &block)
        if current_arbre_element.respond_to?(name)
          current_arbre_element.send name, *args, &block
        elsif assigns && assigns.has_key?(name)
          assigns[name]
        elsif helpers.respond_to?(name)
          helper_capture(name, *args, &block)
        else
          super
        end
      end

      # The helper might have a block that builds Arbre elements
      # which will be rendered (#to_s) inside ActionView::Base#capture.
      # We do not want such elements added to self, so we push a dummy
      # current_arbre_element.
      def helper_capture(name, *args, &block)
        s = ""
        within(Element.new) { s = helpers.send(name, *args, &block) }
        s.is_a?(Element) ? s.to_s : s
      end
    end
  end
end
