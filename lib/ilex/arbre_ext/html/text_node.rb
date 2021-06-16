module Ilex
  module ArbreExt
    module HTML
      module TextNode
        def build(string)
          @content = if string.is_a? Array
                       string.join.html_safe
                     else
                       string
                     end
        end
      end
    end
  end
end