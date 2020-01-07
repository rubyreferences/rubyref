---
title: Calling methods
prev: "/language/methods-def.html"
next: "/language/modules-classes.html"
---

## Calling Methods[](#calling-methods)

Calling a method sends a message to an object so it can perform some work.

In ruby you send a message to an object like this:


```ruby
my_method()
```

Note that the parenthesis are optional:


```ruby
my_method
```

Except when there is difference between using and omitting parentheses, this document uses parenthesis when arguments are present to avoid confusion.

This section only covers calling methods. See also the [syntax documentation on defining methods](methods-def.md).

### Receiver[](#receiver)

`self` is the default receiver. If you don't specify any receiver `self` will be used. To specify a receiver use `.`: 

```ruby
my_object.my_method
```

This sends the `my_method` message to `my_object`. Any object can be a receiver but depending on the method's visibility sending a message may raise a NoMethodError.

You may also use `::` to designate a receiver, but this is rarely used due to the potential for confusion with `::` for namespaces.

#### Safe navigation operator[](#safe-navigation-operator)

`&.`, called "safe navigation operator", allows to skip method call when receiver is `nil`. It returns `nil` and doesn't evaluate method's arguments if the call is skipped.


```ruby
REGEX = /(ruby) is (\w+)/i
"Ruby is awesome!".match(REGEX).values_at(1, 2)
# => ["Ruby", "awesome"]
"Python is fascinating!".match(REGEX).values_at(1, 2)
# NoMethodError: undefined method `values_at` for nil:NilClass
"Python is fascinating!".match(REGEX)&.values_at(1, 2)
# => nil
```

This allows to easily chain methods which could return empty value. Note that `&.` skips only one next call, so for a longer chain it is necessary to add operator on each level:


```ruby
"Python is fascinating!".match(REGEX)&.values_at(1, 2).join(' - ')
# NoMethodError: undefined method `join` for nil:NilClass
"Python is fascinating!".match(REGEX)&.values_at(1, 2)&.join(' - ')
# => nil
```

### Arguments[](#arguments)

There are three types of arguments when sending a message, the positional arguments, keyword (or named) arguments and the block argument. Each message sent may use one, two or all types of arguments, but the arguments must be supplied in this order.

All arguments in ruby are passed by reference and are not lazily evaluated.

Each argument is separated by a `,`: 

```ruby
my_method(1, '2', :three)
```

Arguments may be an expression, a hash argument:


```
'key' => value
```

or a keyword argument:


```
key: value
```

Hash and keyword arguments must be contiguous and must appear after all positional arguments, but may be mixed:


```ruby
my_method('a' => 1, b: 2, 'c' => 3)
```

#### Positional Arguments[](#positional-arguments)

The positional arguments for the message follow the method name:


```ruby
my_method(argument1, argument2)
```

In many cases, parenthesis are not necessary when sending a message:


```ruby
my_method argument1, argument2
```

However, parenthesis are necessary to avoid ambiguity. This will raise a SyntaxError because ruby does not know which method argument3 should be sent to:


```
method_one argument1, method_two argument2, argument3
```

If the method definition has a `*argument` extra positional arguments will be assigned to `argument` in the method as an Array.

If the method definition doesn't include keyword arguments, the keyword or hash-type arguments are assigned as a single hash to the last argument:


```ruby
def my_method(options)
  p options
end

my_method('a' => 1, b: 2) # prints: {'a'=>1, :b=>2}
```

If too many positional arguments are given, an ArgumentError is raised.

#### Default Positional Arguments[](#default-positional-arguments)

When the method defines default arguments you do not need to supply all the arguments to the method. Ruby will fill in the missing arguments in-order.

First we'll cover the simple case where the default arguments appear on the right. Consider this method:


```ruby
def my_method(a, b, c = 3, d = 4)
  p [a, b, c, d]
end
```

Here `c` and `d` have default values which ruby will apply for you. If you send only two arguments to this method:


```ruby
my_method(1, 2)
```

You will see ruby print `[1, 2, 3, 4]`.

If you send three arguments:


```ruby
my_method(1, 2, 5)
```

You will see ruby print `[1, 2, 5, 4]`

Ruby fills in the missing arguments from left to right.

Ruby allows default values to appear in the middle of positional arguments. Consider this more complicated method:


```ruby
def my_method(a, b = 2, c = 3, d)
  p [a, b, c, d]
end
```

Here `b` and `c` have default values. If you send only two arguments to this method:


```ruby
my_method(1, 4)
```

You will see ruby print `[1, 2, 3, 4]`.

If you send three arguments:


```ruby
my_method(1, 5, 6)
```

You will see ruby print `[1, 5, 3, 6]`.

Describing this in words gets complicated and confusing. I'll describe it in variables and values instead.

First `1` is assigned to `a`, then `6` is assigned to `d`. This leaves only the arguments with default values. Since `5` has not been assigned to a value yet, it is given to `b` and `c` uses its default value of `3`.

#### Keyword Arguments[](#keyword-arguments)

Keyword arguments follow any positional arguments and are separated by commas like positional arguments:


```ruby
my_method(positional1, keyword1: value1, keyword2: value2)
```

Any keyword arguments not given will use the default value from the method definition. If a keyword argument is given that the method did not list, and the method definition does not accept arbitrary keyword arguments, an ArgumentError will be raised.

#### Block Argument[](#block-argument)

The block argument sends a closure from the calling scope to the method.

The block argument is always last when sending a message to a method. A block is sent to a method using `do ... end` or `{ ... }`: 

```ruby
my_method do
  # ...
end
```

or:


```ruby
my_method {
  # ...
}
```

`do end` has lower precedence than `{ }` so:


```ruby
method_1 method_2 {
  # ...
}
```

Sends the block to `method_2` while:


```ruby
method_1 method_2 do
  # ...
end
```

Sends the block to `method_1`. Note that in the first case if parentheses are used the block is sent to `method_1`.

A block will accept arguments from the method it was sent to. Arguments are defined similar to the way a method defines arguments. The block's arguments go in `| ... |` following the opening `do` or `{`: 

```ruby
my_method do |argument1, argument2|
  # ...
end
```

##### Block Local Arguments[](#block-local-arguments)

You may also declare block-local arguments to a block using `;` in the block arguments list. Assigning to a block-local argument will not override local arguments outside the block in the caller's scope:


```ruby
def my_method
  yield self
end

place = "world"

my_method do |obj; place|
  place = "block"
  puts "hello #{obj} this is #{place}"
end

puts "place is: #{place}"
```

This prints:


```ruby
hello main this is block
place is world
```

So the `place` variable in the block is not the same `place` variable as outside the block. Removing `; place` from the block arguments gives this result:


```ruby
hello main this is block
place is block
```

#### Array to Arguments Conversion[](#array-to-arguments-conversion)

Given the following method:


```ruby
def my_method(argument1, argument2, argument3)
end
```

You can turn an Array into an argument list with `*` (or splat) operator:


```ruby
arguments = [1, 2, 3]
my_method(*arguments)
```

or:


```ruby
arguments = [2, 3]
my_method(1, *arguments)
```

Both are equivalent to:


```ruby
my_method(1, 2, 3)
```

If the method accepts keyword arguments, the splat operator will convert a hash at the end of the array into keyword arguments:


```ruby
def my_method(a, b, c: 3)
end

arguments = [1, 2, { c: 4 }]
my_method(*arguments)
```

Note that this behavior is currently deprecated and will emit a warning. This behavior will be removed in Ruby 3.0.

You may also use the `**` (described next) to convert a Hash into keyword arguments.

If the number of objects in the Array do not match the number of arguments for the method, an ArgumentError will be raised.

If the splat operator comes first in the call, parentheses must be used to avoid a warning:


```ruby
my_method *arguments  # warning
my_method(*arguments) # no warning
```

#### Hash to Keyword Arguments Conversion[](#hash-to-keyword-arguments-conversion)

Given the following method:


```ruby
def my_method(first: 1, second: 2, third: 3)
end
```

You can turn a Hash into keyword arguments with the `**` (keyword splat) operator:


```ruby
arguments = { first: 3, second: 4, third: 5 }
my_method(**arguments)
```

or:


```ruby
arguments = { first: 3, second: 4 }
my_method(third: 5, **arguments)
```

Both are equivalent to:


```ruby
my_method(first: 3, second: 4, third: 5)
```

If the method definition uses the keyword splat operator to gather arbitrary keyword arguments, they will not be gathered by `*`: 

```ruby
def my_method(*a, **kw)
  p arguments: a, keywords: kw
end

my_method(1, 2, '3' => 4, five: 6)
```

Prints:


```ruby
{:arguments=>[1, 2], :keywords=>{'3'=>4, :five=>6}}
```

#### Proc to Block Conversion[](#proc-to-block-conversion)

Given a method that use a block:


```ruby
def my_method
  yield self
end
```

You can convert a proc or lambda to a block argument with the `&` (block conversion) operator:


```ruby
argument = proc { |a| puts "#{a.inspect} was yielded" }

my_method(&argument)
```

If the block conversion operator comes first in the call, parenthesis must be used to avoid a warning:


```ruby
my_method &argument  # warning
my_method(&argument) # no warning
```

### Method Lookup[](#method-lookup)

When you send a message, Ruby looks up the method that matches the name of the message for the receiver. Methods are stored in classes and modules so method lookup walks these, not the objects themselves.

Here is the order of method lookup for the receiver's class or module `R`: 
* The prepended modules of `R` in reverse order
* For a matching method in `R`
* The included modules of `R` in reverse order

If `R` is a class with a superclass, this is repeated with `R`'s superclass until a method is found.

Once a match is found method lookup stops.

If no match is found this repeats from the beginning, but looking for `method_missing`. The default `method_missing` is `BasicObject#method_missing` which raises a NameError when invoked.

If refinements (an experimental feature) are active, the method lookup changes. See the [refinements documentation](refinements.md) for details.

