# Kernel

The Kernel module is included by class Object, so its methods are available in
every Ruby object.

The Kernel instance methods are documented in class Object while the module
methods are documented here.  These methods are called without a receiver and
thus can be called in functional form:

    sprintf "%.1f", 1.234 #=> "1.2"

[Kernel Reference](https://ruby-doc.org/core-2.5.0/Kernel.html)
