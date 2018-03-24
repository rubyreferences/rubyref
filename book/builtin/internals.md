# ObjectSpace

The ObjectSpace module contains a number of routines that interact with
the garbage collection facility and allow you to traverse all living
objects with an iterator.

ObjectSpace also provides support for object finalizers, procs that will
be called when a specific object is about to be destroyed by garbage
collection.


```ruby
require 'objspace'

a = "A"
b = "B"

ObjectSpace.define_finalizer(a, proc {|id| puts "Finalizer one on #{id}" })
ObjectSpace.define_finalizer(b, proc {|id| puts "Finalizer two on #{id}" })
```

*produces:*


```ruby
Finalizer two on 537763470
Finalizer one on 537763480
```

[ObjectSpace Reference](http://ruby-doc.org/core-2.5.0/ObjectSpace.html)



### ObjectSpace

The objspace library extends the ObjectSpace module and adds several
methods to get internal statistic information about object/memory
management.

You need to `require `objspace'\` to use this extension module.

Generally, you *SHOULD NOT* use this library if you do not know about
the MRI implementation. Mainly, this library is for (memory) profiler
developers and MRI developers who need to know about MRI memory usage.

[ObjectSpace
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/objspace/rdoc/ObjectSpace.html)



## GC

The GC module provides an interface to Ruby's mark and sweep garbage
collection mechanism.

Some of the underlying methods are also available via the ObjectSpace
module.

You may obtain information about the operation of the GC through
GC::Profiler.

[GC Reference](http://ruby-doc.org/core-2.5.0/GC.html)



## TracePoint

A class that provides the functionality of `Kernel#set_trace_func` in a
nice Object-Oriented API.

### Example

We can use TracePoint to gather information specifically for exceptions:


```ruby
trace = TracePoint.new(:raise) do |tp|
    p [tp.lineno, tp.event, tp.raised_exception]
end
#=> #<TracePoint:disabled>

trace.enable
#=> false

0 / 0
#=> [5, :raise, #<ZeroDivisionError: divided by 0>]
```

### Events

If you don't specify the type of events you want to listen for,
TracePoint will include all available events.

**Note** do not depend on current event set, as this list is subject to
change. Instead, it is recommended you specify the type of events you
want to use.

To filter what is traced, you can pass any of the following as
`events`: 
* `:line`: execute code on a new line
* `:class`: start a class or module definition
* `:end`: finish a class or module definition
* `:call`: call a Ruby method
* `:return`: return from a Ruby method
* `:c_call`: call a C-language routine
* `:c_return`: return from a C-language routine
* `:raise`: raise an exception
* `:b_call`: event hook at block entry
* `:b_return`: event hook at block ending
* `:thread_begin`: event hook at thread beginning
* `:thread_end`: event hook at thread ending
* `:fiber_switch`: event hook at fiber switch

[TracePoint Reference](http://ruby-doc.org/core-2.5.0/TracePoint.html)

