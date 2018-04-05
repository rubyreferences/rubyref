---
title: Method and Proc
prev: "/builtin/core/module-class.html"
next: "/builtin/core/binding.html"
---

## Method

Method objects are created by `Object#method`, and are associated with a
particular object (not just with a class). They may be used to invoke
the method within the object, and as a block associated with an
iterator. They may also be unbound from one object (creating an
`UnboundMethod`) and bound to another.


```ruby
class Thing
  def square(n)
    n*n
  end
end
thing = Thing.new
meth  = thing.method(:square)

meth.call(9)                 #=> 81
[ 1, 2, 3 ].collect(&meth)   #=> [1, 4, 9]
```

<a href='https://ruby-doc.org/core-2.5.0/Method.html' class='ruby-doc
remote' target='_blank'>Method Reference</a>



### UnboundMethod

Ruby supports two forms of objectified methods. Class `Method` is used
to represent methods that are associated with a particular object: these
method objects are bound to that object. Bound method objects for an
object can be created using `Object#method`.

Ruby also supports unbound methods; methods objects that are not
associated with a particular object. These can be created either by
calling `Module#instance_method` or by calling `unbind` on a bound
method object. The result of both of these is an `UnboundMethod` object.

Unbound methods can only be called after they are bound to an object.
That object must be a kind\_of? the method's original class.


```ruby
class Square
  def area
    @side * @side
  end
  def initialize(side)
    @side = side
  end
end

area_un = Square.instance_method(:area)

s = Square.new(12)
area = area_un.bind(s)
area.call   #=> 144
```

Unbound methods are a reference to the method at the time it was
objectified: subsequent changes to the underlying class will not affect
the unbound method.


```ruby
class Test
  def test
    :original
  end
end
um = Test.instance_method(:test)
class Test
  def test
    :modified
  end
end
t = Test.new
t.test            #=> :modified
um.bind(t).call   #=> :original
```

<a href='https://ruby-doc.org/core-2.5.0/UnboundMethod.html'
class='ruby-doc remote' target='_blank'>UnboundMethod Reference</a>



### Proc

`Proc` objects are blocks of code that have been bound to a set of local
variables. Once bound, the code may be called in different contexts and
still access those variables.


```ruby
def gen_times(factor)
  return Proc.new {|n| n*factor }
end

times3 = gen_times(3)
times5 = gen_times(5)

times3.call(12)               #=> 36
times5.call(5)                #=> 25
times3.call(times5.call(4))   #=> 60
```

<a href='https://ruby-doc.org/core-2.5.0/Proc.html' class='ruby-doc
remote' target='_blank'>Proc Reference</a>

