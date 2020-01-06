---
title: Keywords
prev: "/language.html"
next: "/language/literals.html"
---

## Keywords[](#keywords)

The following keywords are used by Ruby.

* `__ENCODING__`: The script encoding of the current file. See
  Encoding.

* `__LINE__`: The line number of this keyword in the current file.

* `__FILE__`: The path to the current file.

* `BEGIN`: Runs before any other code in the current file. See
  [miscellaneous syntax](misc.md)

* `END`: Runs after any other code in the current file. See
  [miscellaneous syntax](misc.md)

* `alias`: Creates an alias between two methods (and other things). See
  [modules and classes syntax](modules-classes.md)

* `and`: Short-circuit Boolean and with lower precedence than `&&`

* `begin`: Starts an exception handling block. See [exceptions
  syntax](exceptions.md)

* `break`: Leaves a block early. See [control expressions
  syntax](control-expressions.md)

* `case`: Starts a `case` expression. See [control expressions
  syntax](control-expressions.md)

* `class`: Creates or opens a class. See [modules and classes
  syntax](modules-classes.md)

* `def`: Defines a method. See [methods
  syntax](methods-def.md)

* `defined?`: Returns a string describing its argument. See
  [defined?](language.md#defined)

* `do`: Starts a block.

* `else`: The unhandled condition in `case`, `if` and `unless`
  expressions. See [control
  expressions](control-expressions.md)

* `elsif`: An alternate condition for an `if` expression. See [control
  expressions](control-expressions.md)

* `end`: The end of a syntax block. Used by classes, modules, methods,
  exception handling and control expressions.

* `ensure`: Starts a section of code that is always run when an
  exception is raised. See [exception handling](exceptions.md)

* `false`: Boolean false. See [literals](literals.md)

* `for`: A loop that is similar to using the `each` method. See
  [control expressions](control-expressions.md)

* `if`: Used for `if` and modifier `if` statements. See [control
  expressions](control-expressions.md)

* `in`: Used to separate the iterable object and iterator variable in a
  `for` loop. See [control expressions](control-expressions.md)

* `module`: Creates or opens a module. See [modules and classes
  syntax](modules-classes.md)

* `next`: Skips the rest of the block. See [control
  expressions](control-expressions.md)

* `nil`: A false value usually indicating "no value" or "unknown". See
  [literals](literals.md)

* `not`: Inverts the following boolean expression. Has a lower
  precedence than `!`

* `or`: Boolean or with lower precedence than `||`

* `redo`: Restarts execution in the current block. See [control
  expressions](control-expressions.md)

* `rescue`: Starts an exception section of code in a `begin` block. See
  [exception handling](exceptions.md)

* `retry`: Retries an exception block. See [exception
  handling](exceptions.md)

* `return`: Exits a method. See [methods](methods-def.md). If
  met in top-level scope, immediately stops interpretation of the
  current file.

* `self`: The object the current method is attached to. See
  [methods](methods-def.md)

* `super`: Calls the current method in a superclass. See
  [methods](methods-def.md)

* `then`: Indicates the end of conditional blocks in control
  structures. See [control expressions](control-expressions.md)

* `true`: Boolean true. See [literals](literals.md)

* `undef`: Prevents a class or module from responding to a method call.
  See [modules and classes](modules-classes.md)

* `unless`: Used for `unless` and modifier `unless` statements. See
  [control expressions](control-expressions.md)

* `until`: Creates a loop that executes until the condition is true.
  See [control expressions](control-expressions.md)

* `when`: A condition in a `case` expression. See [control
  expressions](control-expressions.md)

* `while`: Creates a loop that executes while the condition is true.
  See [control expressions](control-expressions.md)

* `yield`: Starts execution of the block sent to the current method.
  See [methods](methods-def.md)

