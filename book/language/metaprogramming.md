# Ruby Metaprogramming

Ruby is known to have very powerful **metaprogramming** capabilities,
that is, defining language structures (classes, modules, methods) at
runtime. Unlike many other languages, Ruby's metaprogramming does not
use special constructs different from "normal" programming, like macros,
decorators or templates. The power of Ruby's metaprogramming comes from
several facts:

* Everything is an object;
* Core classes are hackable;
* Code blocks are useful for concise contextual definitions.

## Everything is an object

That also include core language concepts like classes and methods. They
can be inspected and changed at runtime.


```ruby
class A
  def m(x, y)
  end
end

A.class   #=> Class
A.methods #=> [:new, :allocate, :superclass, ....
A.instance_method(:m) #=> #<UnboundMethod: A#m>
A.instance_method(:m).parameters #=> [[:req, :x], [:req, :y]]
```

## Core classes are hackable

Core classes (like `Class`, `Module`, `Method`) provide methods to
change their behavior and define new concepts with regular Ruby code:


```ruby
# Define methods with names stored in variable
class A
  [:+, :-, :*, :/].each do |op|
    define_method(op) {
      # ...
    }
  end
end

# Call methods, names stored in variable
[:+, :-, :*, :/].map { |op| 100.send(op, 10) } #=> [110, 90, 1000, 10]

# Create classes and assign to constants
[:A, :B, :C].each { |name| Kernel.const_set(name, Class.new) }
```

## Code blocks

## DSL

