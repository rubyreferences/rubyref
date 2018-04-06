# Builting (Core) Classes

This chapter describes classes that are always available in a language, so-called "core" classes.

This is very important topic: in Ruby everything is object, and all expressions except those listed in [dedicated chapter](language/control-expressions.md) are in fact method calls.

For example, this code (which prints "5" to the standard output)

    puts 2 + 3

is, in fact, call of a `Kernel#puts` method, which receives one argument: result of `Integer#+` method of object `2` with argument `3`.

> **Note**: Documentation convention is to write instance methods as `ClassName#method_name`, and class methods as `ClassName.method_name` to clearly distinguish them. `#` is NOT used to call methods in Ruby programs.

The structure of chapter mostly obvious. One important thing to notice: most "basic" methods, available everywhere without target object (like `puts`, or `exit`) are described in [`Kernel` module](builtin/core.md#kernel). This module is included in every object, therefore `puts` is, in fact, `self.puts`. See [Appendix A](appendix-a.md) for a structured list of `Kernel` methods.

Also, the chapter includes parts of standard library documentation where appropriate. E.g., class `Date` (standard library) is documented besides class `Time` (core class). When chapter or section dedicated to standard library class or module, the instructions how to `require` it are mentioned.

The rest of standard library documented in the separate [book part](stdlib.md).