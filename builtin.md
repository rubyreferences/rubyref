---
title: Built-in Classes
prev: "/language/metaprogramming.html"
next: "/builtin/core.html"
---

## Built-in (Core) Classes

This chapter describes classes that are always available in the
language, the so-called "core" classes.

This is a very important topic: in Ruby everything is object, and all
expressions except those listed in [dedicated
chapter](language/control-expressions.md) are in fact method calls.

For example, this code (which prints "5" to the standard output)


```ruby
puts 2 + 3
```

is, in fact, call of the `Kernel#puts` method, which receives one
argument: result of `Integer#+` method of object `2` with argument `3`.

> **Note**\: The documentation convention is to write instance methods
> as `ClassName#method_name`, and class methods as
> `ClassName.method_name` to clearly distinguish them. `#` is NOT used
> to call methods in Ruby programs.

One important thing to notice: most "basic" methods, available
everywhere without a target object (like `puts`, or `exit`), are
described in [`Kernel` module](builtin/core.md#kernel). This module is
included in every object, therefore `puts` is, in fact, `self.puts`. See
[Appendix A](appendix-a.md) for a structured list of `Kernel` methods.

This chapter also includes parts of the standard library documentation
where appropriate. For example, class `Date` (standard library) is
documented beside the class `Time` (core class). When the chapter or
section is dedicated to a standard library class or module, the
instructions to `require` it are included.

The rest of standard library is documented in the [Standard
Library](stdlib.md) chapter.

