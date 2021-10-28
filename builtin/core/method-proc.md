---
title: Method and Proc
prev: "/builtin/core/module-class.html"
next: "/builtin/core/binding.html"
---

## Method[](#method)

Method objects are created by `Object#method`, and are associated with a particular object (not just with a class). They may be used to invoke the method within the object, and as a block associated with an iterator. They may also be unbound from one object (creating an UnboundMethod) and bound to another.


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

[ 1, 2, 3 ].each(&method(:puts)) #=> prints 1, 2, 3

require 'date'
%w[2017-03-01 2017-03-02].collect(&Date.method(:parse))
#=> [#<Date: 2017-03-01 ((2457814j,0s,0n),+0s,2299161j)>, #<Date: 2017-03-02 ((2457815j,0s,0n),+0s,2299161j)>]
```

<a href='https://ruby-doc.org/core-2.7.0/Method.html' class='ruby-doc remote' target='_blank'>Method Reference</a>



### UnboundMethod[](#unboundmethod)

Ruby supports two forms of objectified methods. Class Method is used to represent methods that are associated with a particular object: these method objects are bound to that object. Bound method objects for an object can be created using `Object#method`.

Ruby also supports unbound methods; methods objects that are not associated with a particular object. These can be created either by calling `Module#instance_method` or by calling `#unbind` on a bound method object. The result of both of these is an UnboundMethod object.

Unbound methods can only be called after they are bound to an object. That object must be a kind\_of? the method's original class.


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

Unbound methods are a reference to the method at the time it was objectified: subsequent changes to the underlying class will not affect the unbound method.


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

<a href='https://ruby-doc.org/core-2.7.0/UnboundMethod.html' class='ruby-doc remote' target='_blank'>UnboundMethod Reference</a>



### Proc[](#proc)

A `Proc` object is an encapsulation of a block of code, which can be stored in a local variable, passed to a method or another Proc, and can be called. Proc is an essential concept in Ruby and a core of its functional programming features.


```ruby
square = Proc.new {|x| x**2 }

square.call(3)  #=> 9
# shorthands:
square.(3)      #=> 9
square[3]       #=> 9
```

Proc objects are *closures*, meaning they remember and can use the entire context in which they were created.


```ruby
def gen_times(factor)
  Proc.new {|n| n*factor } # remembers the value of factor at the moment of creation
end

times3 = gen_times(3)
times5 = gen_times(5)

times3.call(12)               #=> 36
times5.call(5)                #=> 25
times3.call(times5.call(4))   #=> 60
```

#### Creation[](#creation)

There are several methods to create a Proc

* Use the Proc class constructor:
  
  
  ```ruby
  proc1 = Proc.new {|x| x**2 }
  ```

* Use the `Kernel#proc` method as a shorthand of Proc.new:
  
  
  ```ruby
  proc2 = proc {|x| x**2 }
  ```

* Receiving a block of code into proc argument (note the `&`):
  
  
  ```ruby
  def make_proc(&block)
    block
  end
  
  proc3 = make_proc {|x| x**2 }
  ```

* Construct a proc with lambda semantics using the `Kernel#lambda` method (see below for explanations about lambdas):
  
  
  ```ruby
  lambda1 = lambda {|x| x**2 }
  ```

* Use the Lambda literal syntax (also constructs a proc with lambda semantics):
  
  
  ```ruby
  lambda2 = ->(x) { x**2 }
  ```

#### Lambda and non-lambda semantics[](#lambda-and-non-lambda-semantics)

Procs are coming in two flavors: lambda and non-lambda (regular procs). Differences are:

* In lambdas, `return` and `break` means exit from this lambda;
* In non-lambda procs, `return` means exit from embracing method (and will throw `LocalJumpError` if invoked outside the method);

* In non-lambda procs, `break` means exit from the method which the block is given for. (and will throw `LocalJumpError` if invoked after the method returns);

* In lambdas, arguments are treated in the same way as in methods: strict, with `ArgumentError` for mismatching argument number, and no additional argument processing;

* Regular procs accept arguments more generously: missing arguments are filled with `nil`, single Array arguments are deconstructed if the proc has multiple arguments, and there is no error raised on extra arguments.

Examples:


```ruby
# +return+ in non-lambda proc, +b+, exits +m2+.
# (The block +{ return }+ is given for +m1+ and embraced by +m2+.)
$a = []; def m1(&b) b.call; $a << :m1 end; def m2() m1 { return }; $a << :m2 end; m2; p $a
#=> []

# +break+ in non-lambda proc, +b+, exits +m1+.
# (The block +{ break }+ is given for +m1+ and embraced by +m2+.)
$a = []; def m1(&b) b.call; $a << :m1 end; def m2() m1 { break }; $a << :m2 end; m2; p $a
#=> [:m2]

# +next+ in non-lambda proc, +b+, exits the block.
# (The block +{ next }+ is given for +m1+ and embraced by +m2+.)
$a = []; def m1(&b) b.call; $a << :m1 end; def m2() m1 { next }; $a << :m2 end; m2; p $a
#=> [:m1, :m2]

# Using +proc+ method changes the behavior as follows because
# The block is given for +proc+ method and embraced by +m2+.
$a = []; def m1(&b) b.call; $a << :m1 end; def m2() m1(&proc { return }); $a << :m2 end; m2; p $a
#=> []
$a = []; def m1(&b) b.call; $a << :m1 end; def m2() m1(&proc { break }); $a << :m2 end; m2; p $a
# break from proc-closure (LocalJumpError)
$a = []; def m1(&b) b.call; $a << :m1 end; def m2() m1(&proc { next }); $a << :m2 end; m2; p $a
#=> [:m1, :m2]

# +return+, +break+ and +next+ in the stubby lambda exits the block.
# (+lambda+ method behaves same.)
# (The block is given for stubby lambda syntax and embraced by +m2+.)
$a = []; def m1(&b) b.call; $a << :m1 end; def m2() m1(&-> { return }); $a << :m2 end; m2; p $a
#=> [:m1, :m2]
$a = []; def m1(&b) b.call; $a << :m1 end; def m2() m1(&-> { break }); $a << :m2 end; m2; p $a
#=> [:m1, :m2]
$a = []; def m1(&b) b.call; $a << :m1 end; def m2() m1(&-> { next }); $a << :m2 end; m2; p $a
#=> [:m1, :m2]

p = proc {|x, y| "x=#{x}, y=#{y}" }
p.call(1, 2)      #=> "x=1, y=2"
p.call([1, 2])    #=> "x=1, y=2", array deconstructed
p.call(1, 2, 8)   #=> "x=1, y=2", extra argument discarded
p.call(1)         #=> "x=1, y=", nil substituted instead of error

l = lambda {|x, y| "x=#{x}, y=#{y}" }
l.call(1, 2)      #=> "x=1, y=2"
l.call([1, 2])    # ArgumentError: wrong number of arguments (given 1, expected 2)
l.call(1, 2, 8)   # ArgumentError: wrong number of arguments (given 3, expected 2)
l.call(1)         # ArgumentError: wrong number of arguments (given 1, expected 2)

def test_return
  -> { return 3 }.call      # just returns from lambda into method body
  proc { return 4 }.call    # returns from method
  return 5
end

test_return # => 4, return from proc
```

Lambdas are useful as self-sufficient functions, in particular useful as arguments to higher-order functions, behaving exactly like Ruby methods.

Procs are useful for implementing iterators:


```ruby
def test
  [[1, 2], [3, 4], [5, 6]].map {|a, b| return a if a + b > 10 }
                            #  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
end
```

Inside `map`, the block of code is treated as a regular (non-lambda) proc, which means that the internal arrays will be deconstructed to pairs of arguments, and `return` will exit from the method `test`. That would not be possible with a stricter lambda.

You can tell a lambda from a regular proc by using the `#lambda?` instance method.

Lambda semantics is typically preserved during the proc lifetime, including `&`-deconstruction to a block of code:


```ruby
p = proc {|x, y| x }
l = lambda {|x, y| x }
[[1, 2], [3, 4]].map(&p) #=> [1, 2]
[[1, 2], [3, 4]].map(&l) # ArgumentError: wrong number of arguments (given 1, expected 2)
```

The only exception is dynamic method definition: even if defined by passing a non-lambda proc, methods still have normal semantics of argument checking.


```ruby
class C
  define_method(:e, &proc {})
end
C.new.e(1,2)       #=> ArgumentError
C.new.method(:e).to_proc.lambda?   #=> true
```

This exception ensures that methods never have unusual argument passing conventions, and makes it easy to have wrappers defining methods that behave as usual.


```ruby
class C
  def self.def2(name, &body)
    define_method(name, &body)
  end

  def2(:f) {}
end
C.new.f(1,2)       #=> ArgumentError
```

The wrapper `def2` receives *body* as a non-lambda proc, yet defines a method which has normal semantics.

#### Conversion of other objects to procs[](#conversion-of-other-objects-to-procs)

Any object that implements the `to_proc` method can be converted into a proc by the `&` operator, and therefore can be consumed by iterators.


```ruby
class Greeter
  def initialize(greeting)
    @greeting = greeting
  end

  def to_proc
    proc {|name| "#{@greeting}, #{name}!" }
  end
end

hi = Greeter.new("Hi")
hey = Greeter.new("Hey")
["Bob", "Jane"].map(&hi)    #=> ["Hi, Bob!", "Hi, Jane!"]
["Bob", "Jane"].map(&hey)   #=> ["Hey, Bob!", "Hey, Jane!"]
```

Of the Ruby core classes, this method is implemented by Symbol, Method, and Hash.


```ruby
:to_s.to_proc.call(1)           #=> "1"
[1, 2].map(&:to_s)              #=> ["1", "2"]

method(:puts).to_proc.call(1)   # prints 1
[1, 2].each(&method(:puts))     # prints 1, 2

{test: 1}.to_proc.call(:test)       #=> 1
%i[test many keys].map(&{test: 1})  #=> [1, nil, nil]
```

#### Orphaned Proc[](#orphaned-proc)

`return` and `break` in a block exit a method. If a Proc object is generated from the block and the Proc object survives until the method is returned, `return` and `break` cannot work. In such case, `return` and `break` raises LocalJumpError. A Proc object in such situation is called as orphaned Proc object.

Note that the method to exit is different for `return` and `break`. There is a situation that orphaned for `break` but not orphaned for `return`.


```ruby
def m1(&b) b.call end; def m2(); m1 { return } end; m2 # ok
def m1(&b) b.call end; def m2(); m1 { break } end; m2 # ok

def m1(&b) b end; def m2(); m1 { return }.call end; m2 # ok
def m1(&b) b end; def m2(); m1 { break }.call end; m2 # LocalJumpError

def m1(&b) b end; def m2(); m1 { return } end; m2.call # LocalJumpError
def m1(&b) b end; def m2(); m1 { break } end; m2.call # LocalJumpError
```

Since `return` and `break` exits the block itself in lambdas, lambdas cannot be orphaned.

#### Numbered parameters[](#numbered-parameters)

Numbered parameters are implicitly defined block parameters intended to simplify writing short blocks:


```ruby
# Explicit parameter:
%w[test me please].each { |str| puts str.upcase } # prints TEST, ME, PLEASE
(1..5).map { |i| i**2 } # => [1, 4, 9, 16, 25]

# Implicit parameter:
%w[test me please].each { puts _1.upcase } # prints TEST, ME, PLEASE
(1..5).map { _1**2 } # => [1, 4, 9, 16, 25]
```

Parameter names from `_1` to `_9` are supported:


```ruby
[10, 20, 30].zip([40, 50, 60], [70, 80, 90]).map { _1 + _2 + _3 }
# => [120, 150, 180]
```

Though, it is advised to resort to them wisely, probably limiting yourself to `_1` and `_2`, and to one-line blocks.

Numbered parameters can't be used together with explicitly named ones:


```ruby
[10, 20, 30].map { |x| _1**2 }
# SyntaxError (ordinary parameter is defined)
```

To avoid conflicts, naming local variables or method arguments `_1`, `_2` and so on, causes a warning.


```ruby
_1 = 'test'
# warning: `_1` is reserved as numbered parameter
```

Using implicit numbered parameters affects block's arity:


```ruby
p = proc { _1 + _2 }
l = lambda { _1 + _2 }
p.parameters     # => [[:opt, :_1], [:opt, :_2]]
p.arity          # => 2
l.parameters     # => [[:req, :_1], [:req, :_2]]
l.arity          # => 2
```

Blocks with numbered parameters can't be nested:


```ruby
%w[test me].each { _1.each_char { p _1 } }
# SyntaxError (numbered parameter is already used in outer block here)
# %w[test me].each { _1.each_char { p _1 } }
#                    ^~
```

Numbered parameters were introduced in Ruby 2.7.

<a href='https://ruby-doc.org/core-2.7.0/Proc.html' class='ruby-doc remote' target='_blank'>Proc Reference</a>

