# Cedar

Cedar allows you to render view_component without a sidecar template. It leverages ActiveAdmin's arbre to provide a pure ruby DSL for creating markup. 
In addition Cedar provides convenience methods for rendering components and component collections.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cedar'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install cedar

## Usage

To use Cedar, you need to extend your components with `Cedar::Component`. The most straight forward way to do this is right
in your base `ApplicationComponent` class.

```ruby
class ApplicationComponent < ViewComponent::Base
  extend Cedar::Component
end
```

`Cedar` provides 3 key pieces of functionality:

# Rendering an arbre tree

`render` is now available to you as a class level method, which renders the contained `arbre` tree.

```ruby
class FoobarComponent < ApplicationComponent
  render do
    div do
      p "Wow this is kind of neat"
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
      p "We're going to render our cool button below"
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
