---
title: Concurrency Utils
prev: "/stdlib/misc.html"
next: "/stdlib/misc/drb.html"
---

## Concurrency Utils[](#concurrency-utils)





### Mutex\_m[](#mutexm)

### mutex\_m.rb[](#mutexmrb)

When 'mutex\_m' is required, any object that extends or includes
Mutex\_m will be treated like a Mutex.

Start by requiring the standard library Mutex\_m:


```ruby
require "mutex_m.rb"
```

From here you can extend an object with Mutex instance methods:


```ruby
obj = Object.new
obj.extend Mutex_m
```

Or mixin Mutex\_m into your module to your class inherit Mutex instance
methods — remember to call super() in your class initialize method.


```ruby
class Foo
  include Mutex_m
  def initialize
    # ...
    super()
  end
  # ...
end
obj = Foo.new
# this obj can be handled like Mutex
```

<a
href='https://ruby-doc.org/stdlib-2.7.0/libdoc/mutex_m/rdoc/Mutex_m.html'
class='ruby-doc remote' target='_blank'>Mutex\_m Reference</a>

