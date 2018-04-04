---
title: tracer
prev: "/stdlib/development/ripper.html"
next: "/stdlib/string-utilities.html"
---

## Tracer

Outputs a source level execution trace of a Ruby program.

It does this by registering an event handler with
`Kernel#set_trace_func` for processing incoming events. It also provides
methods for filtering unwanted trace output (see Tracer.add\_filter,
Tracer.on, and Tracer.off).

### Example

Consider the following Ruby script


```ruby
class A
  def square(a)
    return a*a
  end
end

a = A.new
a.square(5)
```

Running the above script using `ruby -r tracer example.rb` will output
the following trace to STDOUT (Note you can also explicitly `require
`tracer'\`)


```
#0:<internal:lib/rubygems/custom_require>:38:Kernel:<: -
#0:example.rb:3::-: class A
#0:example.rb:3::C: class A
#0:example.rb:4::-:   def square(a)
#0:example.rb:7::E: end
#0:example.rb:9::-: a = A.new
#0:example.rb:10::-: a.square(5)
#0:example.rb:4:A:>:   def square(a)
#0:example.rb:5:A:-:     return a*a
#0:example.rb:6:A:<:   end
 |  |         | |  |
 |  |         | |   ---------------------+ event
 |  |         |  ------------------------+ class
 |  |          --------------------------+ line
 |   ------------------------------------+ filename
  ---------------------------------------+ thread
```

Symbol table used for displaying incoming events:

* +}+: call a C-language routine
* +\{+: return from a C-language routine
* +>+: call a Ruby method
* `C`: start a class or module definition
* `E`: finish a class or module definition
* `-`: execute code on a new line
* +^+: raise an exception
* +<+: return from a Ruby method

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/tracer/rdoc/Tracer.html'
class='ruby-doc remote' target='_blank'>Tracer Reference</a>

