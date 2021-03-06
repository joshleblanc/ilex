# Ilex

Ilex allows you to render view_component without a sidecar template. It leverages ActiveAdmin's arbre to provide a pure ruby DSL for creating markup. 
In addition Ilex provides convenience methods for rendering components and component collections.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ilex'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ilex

## Usage

To use Ilex, you need to extend your components with `Ilex::Component`. The most straight forward way to do this is right
in your base `ApplicationComponent` class.

```ruby
class ApplicationComponent < ViewComponent::Base
  extend Ilex::Component
end
```

`Ilex` provides 3 key pieces of functionality:

# Rendering an arbre tree

`render` is now available to you as a class level method, which renders the contained `arbre` tree.

```ruby
class FoobarComponent < ApplicationComponent
  render do
    div do
      para "Wow this is kind of neat"
    end
  end
end
```

# Rendering components

We provide a shortcut for rendering components themselves. If you have a component called `MyCoolButtonComponent`, you can render this by simply calling `my_cool_button` within your arbre tree.

```ruby
class FoobarComponent < ApplicationComponent
  class MyCoolButtonComponent < ApplicationComponent
    def initialize(label:)
      @label = label  
    end

    render { button_tag "Click me!", class: "btn btn-primary" } 
  end

  render do
    div do
      para "We're going to render our cool button below"
      my_cool_button label: "Click me!"
    end
  end
end
```

## Rendering collections

Suffixing your component tag with `_collection` will render a collection of your components.

```ruby
class FoobarComponent < ApplicationComponent
  class MyCoolButtonComponent < ApplicationComponent
    with_collection_param :label
    def initialize(label:)
      @label = label
    end
    render { button_tag "Click me!", class: "btn btn-primary" } 
  end

  render do
    my_cool_button_collection %w[One Two Three Four]
  end
end
```

## ActionView helpers

If you need to access the underlying rails helpers instead of the arbre helpers, use the `helpers` object.
For example, if you were making a compatible wrapper around `label`:

```ruby
class LabelComponenent < ApplicationComponent
  def initialize(object_name, method, text = nil, options = {})
    @object_name = object_name
    @method = method
    @text = text
    @options = options
    @options[:class] ||= "label"
  end

  render do
    helpers.label @object_name, @method, @text, @options
  end
end
```
