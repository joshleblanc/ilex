module Ilex
  module ArbreExt
    module Element
      module BuilderMethods
        private

        def append_return_block(tag)
          return nil if current_arbre_element.children?
          return unless appendable_tag?(tag)

          current_arbre_element << if tag.is_a? Array
                                     Arbre::HTML::TextNode.from_string(tag.join.html_safe)
                                   else
                                     Arbre::HTML::TextNode.from_string(tag.to_s)
                                   end
        end
      end
    end
  end
end