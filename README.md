## Pub-Sub

![Gem](https://img.shields.io/gem/dt/pub-sub.svg)
![GitHub last commit](https://img.shields.io/github/last-commit/nucleom42/pub-sub.svg)
![Gem](https://img.shields.io/gem/v/pub-sub.svg)

**Problem:**

* Need a simple and light-weight way to use pub sub design pattern in your application?

**Solution:**

* Use pub-sub gem. So you easily can have set of subscribers and publishers which will interact to each other and decouple your code in a smart way!

**Notes:**

* Default container used as a Ruby Hash
* For isolating usage of Hash within one thread, added RequestStore dependency.

## Install

```ruby

gem install pub-sub

```

## Rails

```ruby

gem 'pub-sub', require: 'pub_sub/configuration'

```

## Examples

```ruby
# initialize configuration - set pub-sub container (Ruby Hash by default)
PubSub::Configuration.init

# set subscribers with class method call

# subscriber #1
class SubKlass
  include PubSub::Subscriber

  def self.call(args)
    pp args[:message]
  end
end

# subscriber #2
module Piu
  class SubKlass2
    include PubSub::Subscriber

    def self.call(args)
      pp args[:message] + '2'
    end
  end
end

# subscribe subscribers to event
SubKlass.sub('event')
Piu::SubKlass2.sub('event')

# publish event in order to execute subscribers
class PubKlass
  include PubSub::Publisher

  def publish
    self.class.pub('event', { message: 'notified' })
  end
end


PubKlass.new.publish

# here we go! notified 2
pry(main)> 'notified'
pry(main)> 'notified2'

# unsubscribe
Piu::SubKlass2.unsub('event')

PubKlass.new.publish
# here we go! notified 1
pry(main)> 'notified'
```