# TracePoint

A class that provides the functionality of `Kernel#set_trace_func` in a nice
Object-Oriented API.

## Example

We can use TracePoint to gather information specifically for exceptions:

    trace = TracePoint.new(:raise) do |tp|
        p [tp.lineno, tp.event, tp.raised_exception]
    end
    #=> #<TracePoint:disabled>

    trace.enable
    #=> false

    0 / 0
    #=> [5, :raise, #<ZeroDivisionError: divided by 0>]

## Events

If you don't specify the type of events you want to listen for, TracePoint
will include all available events.

**Note** do not depend on current event set, as this list is subject to
change. Instead, it is recommended you specify the type of events you want to
use.

To filter what is traced, you can pass any of the following as `events`:

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