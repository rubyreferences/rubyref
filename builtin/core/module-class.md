---
title: Module and Class
prev: "/builtin/core/object.html"
next: "/builtin/core/method-proc.html"
---

## Module[](#module)

A Module is a collection of methods and constants. The methods in a module may be instance methods or module methods. Instance methods appear as methods in a class when the module is included, module methods do not. Conversely, module methods may be called without creating an encapsulating object, while instance methods may not. (See `Module#module_function`.)

In the descriptions that follow, the parameter *sym* refers to a symbol, which is either a quoted string or a Symbol (such as `:name`).


```ruby
module Mod
  include Math
  CONST = 1
  def meth
    #  ...
  end
end
Mod.class              #=> Module
Mod.constants          #=> [:CONST, :PI, :E]
Mod.instance_methods   #=> [:meth]
```

<a href='https://ruby-doc.org/core-2.7.0/Module.html' class='ruby-doc remote' target='_blank'>Module Reference</a>



### Class[](#class)

Classes in Ruby are first-class objects—each is an instance of class Class.

Typically, you create a new class by using:


```ruby
class Name
 # some code describing the class behavior
end
```

When a new class is created, an object of type Class is initialized and assigned to a global constant (Name in this case).

When `Name.new` is called to create a new object, the `#new` method in Class is run by default. This can be demonstrated by overriding `#new` in Class:


```ruby
class Class
  alias old_new new
  def new(*args)
    print "Creating a new ", self.name, "\n"
    old_new(*args)
  end
end

class Name
end

n = Name.new
```

*produces:*


```ruby
Creating a new Name
```

Classes, modules, and objects are interrelated. In the diagram that follows, the vertical arrows represent inheritance, and the parentheses metaclasses. All metaclasses are instances of the class `Class`.


```
                         +---------+             +-...
                         |         |             |
         BasicObject-----|-->(BasicObject)-------|-...
             ^           |         ^             |
             |           |         |             |
          Object---------|----->(Object)---------|-...
             ^           |         ^             |
             |           |         |             |
             +-------+   |         +--------+    |
             |       |   |         |        |    |
             |    Module-|---------|--->(Module)-|-...
             |       ^   |         |        ^    |
             |       |   |         |        |    |
             |     Class-|---------|---->(Class)-|-...
             |       ^   |         |        ^    |
             |       +---+         |        +----+
             |                     |
obj--->OtherClass---------->(OtherClass)-----------...
```

<a href='https://ruby-doc.org/core-2.7.0/Class.html' class='ruby-doc remote' target='_blank'>Class Reference</a>

