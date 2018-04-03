# NameError

Raised when a given name is invalid or undefined.

    puts foo

*raises the exception:*

    NameError: undefined local variable or method `foo' for main:Object

Since constant names must start with a capital:

    Integer.const_set :answer, 42

*raises the exception:*

    NameError: wrong constant name answer

[NameError Reference](http://ruby-doc.org/core-2.5.0/NameError.html)
