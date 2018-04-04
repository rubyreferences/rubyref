---
title: Variables and Constants
prev: "/language/comments.html"
next: "/language/assignment.html"
---

## Variables and Constants



### Local Variables



A local variable name must start with a lowercase US-ASCII letter or a
character with the eight bit set. Typically local variables are US-ASCII
compatible since the keys to type them exist on all keyboards.

(Ruby programs must be written in a US-ASCII-compatible character set.
In such character sets if the eight bit is set it indicates an extended
character. Ruby allows local variables to contain such characters.)

A local variable name may contain letters, numbers, an `_` (underscore
or low line) or a character with the eighth bit set.

#### Local Variable Scope

Once a local variable name has been assigned-to all uses of the name for
the rest of the scope are considered local variables.

Here is an example:


```ruby
1.times do
  a = 1
  puts "local variables in the block: #{local_variables.join ", "}"
end

puts "no local variables outside the block" if local_variables.empty?
```

This prints:


```
local variables in the block: a
no local variables outside the block
```

Since the block creates a new scope, any local variables created inside
it do not leak to the surrounding scope.

Variables defined in an outer scope appear inner scope:


```ruby
a = 0

1.times do
  puts "local variables: #{local_variables.join ", "}"
end
```

This prints:


```ruby
local variables: a
```

You may isolate variables in a block from the outer scope by listing
them following a `;` in the block's arguments. See the documentation for
block local variables in the [calling methods](methods-call.md)
documentation for an example.

See also `Kernel#local_variables`, but note that a `for` loop does not
create a new scope like a block does.

#### Local Variables and Methods

In Ruby local variable names and method names are nearly identical. If
you have not assigned to one of these ambiguous names ruby will assume
you wish to call a method. Once you have assigned to the name ruby will
assume you wish to reference a local variable.

The local variable is created when the parser encounters the assignment,
not when the assignment occurs:


```ruby
a = 0 if false # does not assign to a

p local_variables # prints [:a]

p a # prints nil
```

The similarity between method and local variable names can lead to
confusing code, for example:


```ruby
def big_calculation
  42 # pretend this takes a long time
end

big_calculation = big_calculation()
```

Now any reference to `big_calculation` is considered a local variable
and will be cached. To call the method, use `self.big_calculation`.

You can force a method call by using empty argument parentheses as shown
above or by using an explicit receiver like `self.`. Using an explicit
receiver may raise a NameError if the method's visibility is not public.

Another commonly confusing case is when using a modifier `if`: 

```ruby
p a if a = 0.zero?
```

Rather than printing "true" you receive a NameError, "undefined local
variable or method `a`". Since ruby parses the bare `a` left of the `if`
first and has not yet seen an assignment to `a` it assumes you wish to
call a method. Ruby then sees the assignment to `a` and will assume you
are referencing a local method.

The confusion comes from the out-of-order execution of the expression.
First the local variable is assigned-to then you attempt to call a
nonexistent method.



### Instance Variables

Instance variables are shared across all methods for the same object.

An instance variable must start with a `@` ("at" sign or commercial at).
Otherwise instance variable names follow the rules as local variable
names. Since the instance variable starts with an `@` the second
character may be an upper-case letter.

Here is an example of instance variable usage:


```ruby
class C
  def initialize(value)
    @instance_variable = value
  end

  def value
    @instance_variable
  end
end

object1 = C.new "some value"
object2 = C.new "other value"

p object1.value # prints "some value"
p object2.value # prints "other value"
```

An uninitialized instance variable has a value of `nil`. If you run Ruby
with warnings enabled, you will get a warning when accessing an
uninitialized instance variable.

The `value` method has access to the value set by the `initialize`
method, but only for the same object.

### Class Variables

Class variables are shared between a class, its subclasses and its
instances.

A class variable must start with a `@@` (two "at" signs). The rest of
the name follows the same rules as instance variables.

Here is an example:


```ruby
class A
  @@class_variable = 0

  def value
    @@class_variable
  end

  def update
    @@class_variable = @@class_variable + 1
  end
end

class B < A
  def update
    @@class_variable = @@class_variable + 2
  end
end

a = A.new
b = B.new

puts "A value: #{a.value}"
puts "B value: #{b.value}"
```

This prints:


```ruby
A value: 0
B value: 0
```

Continuing with the same example, we can update using objects from
either class and the value is shared:


```ruby
puts "update A"
a.update

puts "A value: #{a.value}"
puts "B value: #{b.value}"

puts "update B"
b.update

puts "A value: #{a.value}"
puts "B value: #{b.value}"

puts "update A"
a.update

puts "A value: #{a.value}"
puts "B value: #{b.value}"
```

This prints:


```ruby
update A
A value: 1
B value: 1
update B
A value: 3
B value: 3
update A
A value: 4
B value: 4
```

Accessing an uninitialized class variable will raise a NameError
exception.

Note that classes have instance variables because classes are objects,
so try not to confuse class and instance variables.

### Global Variables

Global variables are accessible everywhere.

Global variables start with a `$` (dollar sign). The rest of the name
follows the same rules as instance variables.

Here is an example:


```ruby
$global = 0

class C
  puts "in a class: #{$global}"

  def my_method
    puts "in a method: #{$global}"

    $global = $global + 1
    $other_global = 3
  end
end

C.new.my_method

puts "at top-level, $global: #{$global}, $other_global: #{$other_global}"
```

This prints:


```
in a class: 0
in a method: 0
at top-level, $global: 1, $other_global: 3
```

An uninitialized global variable has a value of `nil`.

Ruby has some special globals that behave differently depending on
context such as the regular expression match variables or that have a
side-effect when assigned to. See the [global variables
documentation](globals.md) for details.



### Constants

Constants are defined by assigning value to any identifier starting with
**upper-case letter**\:


```ruby
X = 1
NAMES = %w[Bob Jane Jim]
```

Classes and modules definition (see [Modules and
Classes](./modules-classes.md)) also define constants, assigned to
class/module name:


```ruby
class A
  # ...
end
# Roughly equivalent to:
A = Class.new do
  # ...
end
```

See also: [Constants scoping](./modules-classes.md#constants) section in
"Modules and Classes" chapter.

