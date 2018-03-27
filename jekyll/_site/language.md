# Ruby Language Structure

This chapter describes all syntax constructs and general structure of
Ruby programs.

As a brief overview, it can be said that:

* Ruby program consists of expressions dealing with
  [literals](language/literals.md), [variables](language/variables.md)
  and [constants](language/variables.md#constants).
* Expressions are:
  * [assignments](language/assignments.md);
  * [control expressions](language/control-expressions.md);
  * [method calls](language/methods-call.md);
  * definitions of modules, classes and methods.

* Ruby is object-oriented language, so the program is structured by
  defining [classes and modules](language/modules-classes.md) and their
  [methods](language/methods-def.md).
  * Ruby has open classes, for hygiene one can use
    [refinements](language/refinements.md).

* Error reporting and handling is done with
  [exceptions](language/exceptions.md).



## Ending an Expression

Ruby uses a newline as the end of an expression. When ending a line with
an operator, open parentheses, comma, etc. the expression will continue.

You can end an expression with a `;` (semicolon). Semicolons are most
frequently used with `ruby -e`.



## Indentation

Ruby does not require any indentation. Typically, ruby programs are
indented two spaces.

If you run ruby with warnings enabled and have an indentation mis-match,
you will receive a warning.



## `defined?`

`defined?` is a keyword that returns a string describing its argument:


```ruby
p defined?(UNDEFINED_CONSTANT) # prints nil
p defined?(RUBY_VERSION)       # prints "constant"
p defined?(1 + 1)              # prints "method"
```

You don't need to use parenthesis with `defined?`, but they are
recommended due to the [low precedence](rdoc-ref:syntax/precedence.rdoc)
of `defined?`.

For example, if you wish to check if an instance variable exists and
that the instance variable is zero:


```ruby
defined? @instance_variable && @instance_variable.zero?
```

This returns `"expression"`, which is not what you want if the instance
variable is not defined.


```ruby
@instance_variable = 1
defined?(@instance_variable) && @instance_variable.zero?
```

Adding parentheses when checking if the instance variable is defined is
a better check. This correctly returns `nil` when the instance variable
is not defined and `false` when the instance variable is not zero.

Using the specific reflection methods such as
instance\_variable\_defined? for instance variables or const\_defined?
for constants is less error prone than using `defined?`.



## `BEGIN` and `END`

`BEGIN` defines a block that is run before any other code in the current
file. It is typically used in one-liners with `ruby -e`. Similarly `END`
defines a block that is run after any other code.

`BEGIN` must appear at top-level and `END` will issue a warning when you
use it inside a method.

Here is an example:


```ruby
BEGIN {
  count = 0
}
```

You must use `{` and `}` you may not use `do` and `end`.

Here is an example one-liner that adds numbers from standard input or
any files in the argument list:


```
ruby -ne 'BEGIN { count = 0 }; END { puts count }; count += gets.to_i'
```

