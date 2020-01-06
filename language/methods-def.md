---
title: Defining methods
prev: "/language/pattern-matching.html"
next: "/language/methods-call.html"
---

## Methods[](#methods)

Methods implement the functionality of your program. Here is a simple method definition:


```ruby
def one_plus_one
  1 + 1
end
```

A method definition consists of the `def` keyword, a method name, the body of the method, `return` value and the `end` keyword. When called the method will execute the body of the method. This method returns `2`.

This section only covers defining methods. See also the [syntax documentation on calling methods](methods-call.md).

### Method Names[](#method-names)

Method names may be one of the operators or must start a letter or a character with the eighth bit set. It may contain letters, numbers, an `_` (underscore or low line) or a character with the eighth bit set. The convention is to use underscores to separate words in a multiword method name:


```ruby
def method_name
  puts "use underscores to separate words"
end
```

Ruby programs must be written in a US-ASCII-compatible character set such as UTF-8, ISO-8859-1 etc. In such character sets if the eighth bit is set it indicates an extended character. Ruby allows method names and other identifiers to contain such characters. Ruby programs cannot contain some characters like ASCII NUL (`\x00`).

The following are examples of valid Ruby methods:


```ruby
def hello
  "hello"
end

def こんにちは
  puts "means hello in Japanese"
end
```

Typically method names are US-ASCII compatible since the keys to type them exist on all keyboards.

Method names may end with a `!` (bang or exclamation mark), a `?` (question mark), or `=` (equals sign).

The bang methods (`!` at the end of the method name) are called and executed just like any other method. However, by convention, a method with an exclamation point or bang is considered dangerous. In Ruby's core library the dangerous method implies that when a method ends with a bang (`!`), it indicates that unlike its non-bang equivalent, permanently modifies its receiver. Almost always, the Ruby core library will have a non-bang counterpart (method name which does NOT end with `!`) of every bang method (method name which does end with `!`) that does not modify the receiver. This convention is typically true for the Ruby core library but may or may not hold true for other Ruby libraries.

Methods that end with a question mark by convention return boolean, but they may not always return just `true` or `false`. Often, they will return an object to indicate a true value (or "truthy" value).

Methods that end with an equals sign indicate an assignment method.

These are method names for the various Ruby operators. Each of these operators accepts only one argument. Following the operator is the typical use or name of the operator. Creating an alternate meaning for the operator may lead to confusion as the user expects plus to add things, minus to subtract things, etc. Additionally, you cannot alter the precedence of the operators.

* `+`: add
* `-`: subtract
* `*`: multiply
* `**`: power
* `/`: divide
* `%`: modulus division, String#%
* `&`: AND
* `^`: XOR (exclusive OR)
* `>>`: right-shift
* `<<`: left-shift, append
* `==`: equal
* `!=`: not equal
* `===`: case equality. See `Object#===`
* `=~`: pattern match. (Not just for regular expressions)
* `!~`: does not match
* `<=>`: comparison aka spaceship operator. See Comparable
* `<`: less-than
* `<=`: less-than or equal
* `>`: greater-than
* `>=`: greater-than or equal

To define unary methods minus and plus, follow the operator with an `@` as in `+@`: 

```ruby
class C
  def -@
    puts "you inverted this object"
  end
end

obj = C.new

-obj # prints "you inverted this object"
```

The `@` is needed to differentiate unary minus and plus operators from binary minus and plus operators.

You can also follow tilde and not (`!`) unary methods with `@`, but it is not required as there are no binary tilde and not operators.

Unary methods accept zero arguments.

Additionally, methods for element reference and assignment may be defined: `[]` and `[]=` respectively. Both can take one or more arguments, and element reference can take none.


```ruby
class C
  def [](a, b)
    puts a + b
  end

  def []=(a, b, c)
    puts a * b + c
  end
end

obj = C.new

obj[2, 3]     # prints "5"
obj[2, 3] = 4 # prints "10"
```

### Return Values[](#return-values)

By default, a method returns the last expression that was evaluated in the body of the method. In the example above, the last (and only) expression evaluated was the simple sum `1 + 1`. The `return` keyword can be used to make it explicit that a method returns a value.


```ruby
def one_plus_one
  return 1 + 1
end
```

It can also be used to make a method return before the last expression is evaluated.


```ruby
def two_plus_two
  return 2 + 2
  1 + 1  # this expression is never evaluated
end
```

Note that for assignment methods the return value will be ignored when using the assignment syntax. Instead, the argument will be returned:


```ruby
def a=(value)
  return 1 + value
end

p(self.a = 5) # prints 5
```

The actual return value will be returned when invoking the method directly:


```ruby
p send(:a=, 5) # prints 6
```

### Scope[](#scope)

The standard syntax to define a method:


```ruby
def my_method
  # ...
end
```

adds the method to a class. You can define an instance method on a specific class with the `class` keyword:


```ruby
class C
  def my_method
    # ...
  end
end
```

A method may be defined on another object. You may define a "class method" (a method that is defined on the class, not an instance of the class) like this:


```ruby
class C
  def self.my_method
    # ...
  end
end
```

However, this is simply a special case of a greater syntactical power in Ruby, the ability to add methods to any object. Classes are objects, so adding class methods is simply adding methods to the Class object.

The syntax for adding a method to an object is as follows:


```ruby
greeting = "Hello"

def greeting.broaden
  self + ", world!"
end

greeting.broaden # returns "Hello, world!"
```

`self` is a keyword referring to the current object under consideration by the compiler, which might make the use of `self` in defining a class method above a little clearer. Indeed, the example of adding a `hello` method to the class `String` can be rewritten thus:


```ruby
def String.hello
  "Hello, world!"
end
```

A method defined like this is called a "singleton method". `broaden` will only exist on the string instance `greeting`. Other strings will not have `broaden`.

### Overriding[](#overriding)

When Ruby encounters the `def` keyword, it doesn't consider it an error if the method already exists: it simply redefines it. This is called *overriding*. Rather like extending core classes, this is a potentially dangerous ability, and should be used sparingly because it can cause unexpected results. For example, consider this irb session:


```
>> "43".to_i
=> 43
>> class String
>>   def to_i
>>     42
>>   end
>> end
=> nil
>> "43".to_i
=> 42
```

This will effectively sabotage any code which makes use of the method `String#to_i` to parse numbers from strings.

### Arguments[](#arguments)

A method may accept arguments. The argument list follows the method name:


```ruby
def add_one(value)
  value + 1
end
```

When called, the user of the `add_one` method must provide an argument. The argument is a local variable in the method body. The method will then add one to this argument and return the value. If given `1` this method will return `2`.

The parentheses around the arguments are optional:


```ruby
def add_one value
  value + 1
end
```

Multiple arguments are separated by a comma:


```ruby
def add_values(a, b)
  a + b
end
```

When called, the arguments must be provided in the exact order. In other words, the arguments are positional.

Repeated argument names is syntax error. There is one exception: the special name `_` to designate unused argument(s).


```
def some_method(x, y, x) # Syntax error
  # ...
end

def some_method(_, y, _) # OK
  # ...
end
```

This is useful for redefining methods, when client code expects a particular calling convention.

#### Default Values[](#default-values)

Arguments may have default values:


```ruby
def add_values(a, b = 1)
  a + b
end
```

The default value does not need to appear first, but arguments with defaults must be grouped together. This is ok:


```ruby
def add_values(a = 1, b = 2, c)
  a + b + c
end
```

This will raise a SyntaxError:


```
def add_values(a = 1, b, c = 1)
  a + b + c
end
```

Default argument values can refer to arguments that have already been evaluated as local variables, and argument values are always evaluated left to right. So this is allowed:


```ruby
def add_values(a = 1, b = a)
  a + b
end
add_values
# => 2
```

But this will raise a `NameError` (unless there is a method named `b` defined):


```ruby
def add_values(a = b, b = 1)
  a + b
end
add_values
# NameError (undefined local variable or method `b` for main:Object)
```

#### Array Decomposition[](#array-decomposition)

You can decompose (unpack or extract values from) an Array using extra parentheses in the arguments:


```ruby
def my_method((a, b))
  p a: a, b: b
end

my_method([1, 2])
```

This prints:


```ruby
{:a=>1, :b=>2}
```

If the argument has extra elements in the Array they will be ignored:


```ruby
def my_method((a, b))
  p a: a, b: b
end

my_method([1, 2, 3])
```

This has the same output as above.

You can use a `*` to collect the remaining arguments. This splits an Array into a first element and the rest:


```ruby
def my_method((a, *b))
  p a: a, b: b
end

my_method([1, 2, 3])
```

This prints:


```ruby
{:a=>1, :b=>[2, 3]}
```

The argument will be decomposed if it responds to `#to_ary`. You should only define `#to_ary` if you can use your object in place of an Array.

Use of the inner parentheses only uses one of the sent arguments. If the argument is not an Array it will be assigned to the first argument in the decomposition and the remaining arguments in the decomposition will be `nil`: 

```ruby
def my_method(a, (b, c), d)
  p a: a, b: b, c: c, d: d
end

my_method(1, 2, 3)
```

This prints:


```ruby
{:a=>1, :b=>2, :c=>nil, :d=>3}
```

You can nest decomposition arbitrarily:


```ruby
def my_method(((a, b), c))
  # ...
end
```

#### Array/Hash Argument[](#arrayhash-argument)

Prefixing an argument with `*` causes any remaining arguments to be converted to an Array:


```ruby
def gather_arguments(*arguments)
  p arguments
end

gather_arguments 1, 2, 3 # prints [1, 2, 3]
```

The array argument must be the last positional argument, it must appear before any keyword arguments.

The array argument will capture a Hash as the last entry if a hash was sent by the caller after all positional arguments.


```ruby
gather_arguments 1, a: 2 # prints [1, {:a=>2}]
```

However, this only occurs if the method does not declare any keyword arguments.


```ruby
def gather_arguments_keyword(*positional, keyword: nil)
 p positional: positional, keyword: keyword
end

gather_arguments_keyword 1, 2, three: 3
#=> raises: unknown keyword: three (ArgumentError)
```

Also, note that a bare `*` can be used to ignore arguments:


```ruby
def ignore_arguments(*)
end
```

#### Keyword Arguments[](#keyword-arguments)

Keyword arguments are similar to positional arguments with default values:


```ruby
def add_values(first: 1, second: 2)
  first + second
end
```

Arbitrary keyword arguments will be accepted with `**`: 

```ruby
def gather_arguments(first: nil, **rest)
  p first, rest
end

gather_arguments first: 1, second: 2, third: 3
# prints 1 then {:second=>2, :third=>3}
```

When calling a method with keyword arguments the arguments may appear in any order. If an unknown keyword argument is sent by the caller, and the method does not accept arbitrary keyword arguments, an ArgumentError is raised.

To require a specific keyword argument, do not include a default value for the keyword argument:


```ruby
def add_values(first:, second:)
  first + second
end
add_values
# ArgumentError (missing keywords: first, second)
add_values(first: 1, second: 2)
# => 3
```

When mixing keyword arguments and positional arguments, all positional arguments must appear before any keyword arguments.

It is possible to define a keyword argument with name that is not acceptable for a variable name, like `class` or `next` (keywords). In this case, argument's value can be obtained via [Binding](../builtin/core.md#binding).


```ruby
def html_tag(name, class:)
  # Will fail with SyntaxError
  # puts class

  # Works
  puts binding.local_variable_get('class')
end
```

Also, note that `**` can be used to ignore keyword arguments:


```ruby
def ignore_keywords(**)
end
```

To mark a method as accepting keywords, but not actually accepting keywords, you can use the `**nil`: 

```ruby
def no_keywords(**nil)
end
```

Calling such a method with keywords or a non-empty keyword splat will result in an ArgumentError. This syntax is supported so that keywords can be added to the method later without affected backwards compatibility.

#### Keyword and Positional Argument Separation[](#keyword-and-positional-argument-separation)

Between Ruby 2.0 and 2.6, keyword and positional arguments were not separated, and a keyword argument could be used as a positional argument and vice-versa. In Ruby 3.0, keyword and positional arguments will be separated if the method definition includes keyword arguments. In Ruby 3.0, if the method definition does not include keyword arguments, keyword arguments provided when calling the method will continue to be treated as a final positional hash argument.

Currently, the keyword and positional arguments are not separated, but cases where behavior will change in Ruby 3.0 will result in a warning being emitted.

There are a few different types of keyword argument separation issues.

##### Conversion of Hash to Keywords[](#conversion-of-hash-to-keywords)

If a method is called with the hash, the hash could be treated as keywords:


```ruby
def my_method(**keywords)
  keywords
end
my_method({a: 1}) # {:a => 1}
```

This occurs even if the hash could be an optional positional argument or an element of a rest argument:


```ruby
def my_method(hash=nil, **keywords)
  [hash, keywords]
end
my_method({a: 1}) # [nil, {:a => 1}]

def my_method(*args, **keywords)
  [args, keywords]
end
my_method({a: 1}) # [[], {:a => 1}]
```

However, if the hash is needed for a mandatory positional argument, it would not be treated as keywords:


```ruby
def my_method(hash, **keywords)
  [hash, keywords]
end
my_method({a: 1}) # [{:a => 1}, {}]
```

##### Conversion of Keywords to Positional Arguments[](#conversion-of-keywords-to-positional-arguments)

If a method is called with keywords, but it is missing one mandatory positional argument, the keywords are converted to a hash and the hash used as the mandatory positional argument:


```ruby
def my_method(hash, **keywords)
  [hash, keywords]
end
my_method(a: 1) # [{:a => 1}, {}]
```

This is also true for empty keyword splats:


```ruby
kw = {}
my_method(**kw) # [{}, {}]
```

##### Splitting of Positional Hashes or Keywords[](#splitting-of-positional-hashes-or-keywords)

If a method definition accepts specific keywords and not arbitrary keywords, keywords or a positional hash may be split if the hash includes both Symbol keys and non-Symbol keys and the keywords or positional hash are not needed as a mandatory positional argument. In this case, the non-Symbol keys are separated into a positional argument hash, and the Symbol keys are used as the keyword arguments:


```ruby
def my_method(hash=3, a: 4)
  [hash, a]
end
my_method(a: 1, 'a' => 2)   # [{"a"=>2}, 1]
my_method({a: 1, 'a' => 2}) # [{"a"=>2}, 1]
```

### Block Argument[](#block-argument)

The block argument is indicated by `&` and must come last:


```ruby
def my_method(&my_block)
  my_block.call(self)
end
```

Most frequently the block argument is used to pass a block to another method:


```ruby
def each_item(&block)
  @items.each(&block)
end
```

If you are only going to call the block and will not otherwise manipulate it or send it to another method using `yield` without an explicit block parameter is preferred. This method is equivalent to the first method in this section:


```ruby
def my_method
  yield self
end
```

### Exception Handling[](#exception-handling)

Methods have an implied exception handling block so you do not need to use `begin` or `end` to handle exceptions. This:


```ruby
def my_method
  begin
    # code that may raise an exception
  rescue
    # handle exception
  end
end
```

May be written as:


```ruby
def my_method
  # code that may raise an exception
rescue
  # handle exception
end
```

Similarly, if you wish to always run code even if an exception is raised, you can use `ensure` without `begin` and `end`: 

```ruby
def my_method
  # code that may raise an exception
ensure
  # code that runs even if previous code raised an exception
end
```

You can also combine `rescue` with `ensure` and/or `else`, without `begin` and `end`: 

```ruby
def my_method
  # code that may raise an exception
rescue
  # handle exception
else
  # only run if no exception raised above
ensure
  # code that runs even if previous code raised an exception
end
```

If you wish to rescue an exception for only part of your method, use `begin` and `end`. For more details see the page on [exception handling](exceptions.md).

### Method definition as an expression[](#method-definition-as-an-expression)

`def` (method definition) is an *expression* returning the name of the defined method. This feature is mostly useful for method decoration:


```ruby
# Ruby's standard visibility statement
private def some_private_method
  # ...
end

# Decorating with third-party library for memoizing (caching) method value
memoize def some_expensive_method
  # ...
end
```

`private` and `memoize` above are just method calls, receiving the result of `def` (method name to make private/cached) as their argument.



#### `alias`[](#alias)

The `alias` keyword is most frequently used to alias methods. When aliasing a method, you can use either its name or a symbol:


```ruby
alias new_name old_name
alias :new_name :old_name
```

For methods, `Module#alias_method` can often be used instead of `alias`.

You can also use `alias` to alias global variables:


```ruby
$old = 0

alias $new $old

p $new # prints 0
```

You may use `alias` in any scope.

#### `undef`[](#undef)

The `undef` keyword prevents the current class from responding to calls to the named methods.


```ruby
undef my_method
```

You may use symbols instead of method names:


```ruby
undef :my_method
```

You may undef multiple methods:


```ruby
undef method1, method2
```

You may use `undef` in any scope. See also `Module#undef_method`

