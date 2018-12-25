---
title: singleton
prev: "/stdlib/patterns/observer.html"
next: "/stdlib/formats.html"
---


```ruby
require 'singleton'
```

## Singleton[](#singleton)

The Singleton module implements the Singleton pattern.

### Usage[](#usage)

To use Singleton, include the module in your class.


```ruby
class Klass
   include Singleton
   # ...
end
```

This ensures that only one instance of Klass can be created.


```ruby
a,b  = Klass.instance, Klass.instance

a == b
# => true

Klass.new
# => NoMethodError - new is private ...
```

The instance is created at upon the first call of Klass.instance().


```ruby
class OtherKlass
  include Singleton
  # ...
end

ObjectSpace.each_object(OtherKlass){}
# => 0

OtherKlass.instance
ObjectSpace.each_object(OtherKlass){}
# => 1
```

This behavior is preserved under inheritance and cloning.

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/singleton/rdoc/Singleton.html'
class='ruby-doc remote' target='_blank'>Singleton Reference</a>

