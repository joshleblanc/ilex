# frozen_string_literal: true

require 'arbre'
require_relative "ilex/version"
require_relative "ilex/component_warden"
require_relative "ilex/component_wardens"
require_relative "ilex/context"
require_relative "ilex/component"
require_relative "ilex/arbre_ext/element"
require_relative "ilex/arbre_ext/element/builder_methods"
require_relative "ilex/arbre_ext/html/text_node"
require_relative "ilex/rails_ext/action_view/base"
require_relative "ilex/engine"

module Ilex
  class Error < StandardError; end
  # Your code goes here...
end

