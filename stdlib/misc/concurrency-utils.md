---
title: Concurrency Utils
prev: "/stdlib/misc.html"
next: "/stdlib/misc/drb.html"
---

## Concurrency Utils[](#concurrency-utils)



### Monitor[](#monitor)

Use the Monitor class when you want to have a lock object for blocks
with mutual exclusion.


```ruby
require 'monitor'

lock = Monitor.new
lock.synchronize do
  # exclusive access
end
```

<a
href='https://ruby-doc.org/stdlib-2.6/libdoc/monitor/rdoc/Monitor.html'
class='ruby-doc remote' target='_blank'>Monitor Reference</a>



### MonitorMixin[](#monitormixin)

In concurrent programming, a monitor is an object or module intended to
be used safely by more than one thread. The defining characteristic of a
monitor is that its methods are executed with mutual exclusion. That is,
at each point in time, at most one thread may be executing any of its
methods. This mutual exclusion greatly simplifies reasoning about the
implementation of monitors compared to reasoning about parallel code
that updates a data structure.

You can read more about the general principles on the Wikipedia page for
<a href='http://en.wikipedia.org/wiki/Monitor_%28synchronization%29'
class='remote' target='_blank'>Monitors</a>

#### Examples[](#examples)

##### Simple object.extend[](#simple-objectextend)


```ruby
require 'monitor.rb'

buf = []
buf.extend(MonitorMixin)
empty_cond = buf.new_cond

# consumer
Thread.start do
  loop do
    buf.synchronize do
      empty_cond.wait_while { buf.empty? }
      print buf.shift
    end
  end
end

# producer
while line = ARGF.gets
  buf.synchronize do
    buf.push(line)
    empty_cond.signal
  end
end
```

The consumer thread waits for the producer thread to push a line to buf
while `buf.empty?`. The producer thread (main thread) reads a line from
ARGF and pushes it into buf then calls `empty_cond.signal` to notify the
consumer thread of new data.

##### Simple Class include[](#simple-class-include)


```ruby
require 'monitor'

class SynchronizedArray < Array

  include MonitorMixin

  def initialize(*args)
    super(*args)
  end

  alias :old_shift :shift
  alias :old_unshift :unshift

  def shift(n=1)
    self.synchronize do
      self.old_shift(n)
    end
  end

  def unshift(item)
    self.synchronize do
      self.old_unshift(item)
    end
  end

  # other methods ...
end
```

`SynchronizedArray` implements an Array with synchronized access to
items. This Class is implemented as subclass of Array which includes the
MonitorMixin module.

<a
href='https://ruby-doc.org/stdlib-2.6/libdoc/monitor/rdoc/MonitorMixin.html'
class='ruby-doc remote' target='_blank'>MonitorMixin Reference</a>



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
href='https://ruby-doc.org/stdlib-2.6/libdoc/mutex_m/rdoc/Mutex_m.html'
class='ruby-doc remote' target='_blank'>Mutex\_m Reference</a>



### Sync[](#sync)

A class that provides two-phase lock with a counter. See Sync\_m for
details.

<a href='https://ruby-doc.org/stdlib-2.6/libdoc/sync/rdoc/Sync.html'
class='ruby-doc remote' target='_blank'>Sync Reference</a>



### Sync\_m[](#syncm)

A module that provides a two-phase lock with a counter.

<a href='https://ruby-doc.org/stdlib-2.6/libdoc/sync/rdoc/Sync_m.html'
class='ruby-doc remote' target='_blank'>Sync\_m Reference</a>



### Synchronizer[](#synchronizer)

A class that provides two-phase lock with a counter. See Sync\_m for
details.

<a
href='https://ruby-doc.org/stdlib-2.6/libdoc/sync/rdoc/Synchronizer.html'
class='ruby-doc remote' target='_blank'>Synchronizer Reference</a>



### Synchronizer\_m[](#synchronizerm)

A module that provides a two-phase lock with a counter.

<a
href='https://ruby-doc.org/stdlib-2.6/libdoc/sync/rdoc/Synchronizer_m.html'
class='ruby-doc remote' target='_blank'>Synchronizer\_m Reference</a>

