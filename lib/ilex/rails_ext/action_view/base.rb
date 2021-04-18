module Ilex
  module RailsExt
    module ActionView
      module Base
        def capture(*args)
          value = nil
          buffer = with_output_buffer { value = yield(*args) }

          # Override to handle Arbre elements inside helper blocks.
          # See https://github.com/rails/rails/issues/17661
          # and https://github.com/rails/rails/pull/18024#commitcomment-8975180
          value = value.to_s if value.is_a?(Arbre::Element)

          if (string = buffer.presence || value) && string.is_a?(String)
            ERB::Util.html_escape string
          end
        end
      end
    end
  end
end
