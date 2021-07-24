module Ilex
  module RailsExt
    module ActionView
      module Base
        def capture(*args)
          value = nil
          buffer = with_output_buffer { value = yield(*args) }
        
          # if args.first&.respond_to? :ctx 
          #   value = args.first.ctx.children.to_s
          # end
          # We're only capturing the last returned arbre element
          # This uses that element to get the current context, and 
          # get the html for the whole tree
          # We have to collect the children manually because 
          # `content` is overridden 
          if value.is_a? Arbre::Element
            value = value.arbre_context.children.to_s
          end

          if (string = buffer.presence || value) && string.is_a?(String)
            ERB::Util.html_escape string
          end
        end
      end
    end
  end
end
