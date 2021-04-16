# frozen_string_literal: true

require "test_helper"

class IlexTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ilex::VERSION
  end
end
