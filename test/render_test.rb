require_relative "test_helper"

class TestComponent < ViewComponent::Base
  extend Ilex::Component

  render do
    div "Hello!"
  end
end

class RenderTest < ViewComponent::TestCase
  def test_its_speed
    Benchmark.bmbm do |x|
      x.report "arbre" do
        10000.times do
          render_inline(TestComponent.new)
        end
      end
      x.report "vc" do
        10000.times do
          render_inline(TestVcComponent.new)
        end
      end
      x.report "partial" do
        10000.times do
          ActionController::Base.render partial: "test/test"
        end
      end
    end
  end
end
