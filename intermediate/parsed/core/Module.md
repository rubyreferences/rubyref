# Module

A `Module` is a collection of methods and constants. The methods in a module
may be instance methods or module methods. Instance methods appear as methods
in a class when the module is included, module methods do not. Conversely,
module methods may be called without creating an encapsulating object, while
instance methods may not. (See `Module#module_function`.)

In the descriptions that follow, the parameter *sym* refers to a symbol, which
is either a quoted string or a `Symbol` (such as `:name`).

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
