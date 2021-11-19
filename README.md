## Pub-Sub

![Gem](https://img.shields.io/gem/dt/pub-sub.svg)
![GitHub last commit](https://img.shields.io/github/last-commit/nucleom42/pub-sub.svg)
![Gem](https://img.shields.io/gem/v/pub-sub.svg)

**Problem:**

* Need a simple and light-weight way to use pub sub design pattern in your application?

**Solution:**

* Use pub-sub gem. So you easily can have set of subscribers and publishers which will interact to each other and decouple your code in a smart way!

**Notes:**

## Install

```ruby

gem install pub-sub

```

## Rails

```ruby

gem 'pub-sub', require: %w[pub_sub/configuration]

```

## Examples

```ruby
# set container in initializer
PubSub::Configuration.this
# as a container by default it takes Ruby Hash

# set subscribers with class method call
class SubKlass
  include PubSub::Subscriber

  def self.call(args)
    pp args[:message]
  end
end

# subscribe subscriber to event
SubKlass.sub('event')

# publish event in order to execute subscribers
class PubKlass
  include PubSub::Publisher

  def publish
    self.pub('event', { message: 'notified' })
  end
end


PubKlass.new.publish

# here we go! notified 
pry(main)> 'notified'

```