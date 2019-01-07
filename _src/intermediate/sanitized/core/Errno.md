# Errno

Ruby exception objects are subclasses of `Exception`. However, operating
systems typically report errors using plain integers. Module `Errno` is
created dynamically to map these operating system errors to Ruby classes, with
each error number generating its own subclass of `SystemCallError`. As the
subclass is created in module `Errno`, its name will start `Errno::`.

The names of the `Errno::` classes depend on the environment in which Ruby
runs. On a typical Unix or Windows platform, there are `Errno` classes such as
`Errno::EACCES`, `Errno::EAGAIN`, `Errno::EINTR`, and so on.

The integer operating system error number corresponding to a particular error
is available as the class constant `Errno::`*error*`::Errno`.

    Errno::EACCES::Errno   #=> 13
    Errno::EAGAIN::Errno   #=> 11
    Errno::EINTR::Errno    #=> 4

The full list of operating system errors on your particular platform are
available as the constants of `Errno`.

    Errno.constants   #=> :E2BIG, :EACCES, :EADDRINUSE, :EADDRNOTAVAIL, ...

[Errno Reference](https://ruby-doc.org/core-2.6/Errno.html)