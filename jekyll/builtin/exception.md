---
title: Exception
prev: "/builtin/types/matrix.html"
next: "/builtin/exception/exception-classes.html"
---

# Exception

Descendants of class Exception are used to communicate between
`Kernel#raise` and `rescue` statements in `begin ... end` blocks.
Exception objects carry information about the exception -- its type (the
exception's class name), an optional descriptive string, and optional
traceback information. Exception subclasses may add additional
information like `NameError#name`.

Programs may make subclasses of Exception, typically of StandardError or
RuntimeError, to provide custom classes and add additional information.
See the subclass list below for defaults for `raise` and `rescue`.

When an exception has been raised but not yet handled (in `rescue`,
`ensure`, `at_exit` and `END` blocks) the global variable `$!` will
contain the current exception and `$@` contains the current exception's
backtrace.

It is recommended that a library should have one subclass of
StandardError or RuntimeError and have specific exception types inherit
from it. This allows the user to rescue a generic exception type to
catch all exceptions the library may raise even if future versions of
the library add new exception subclasses.

For example:


```ruby
class MyLibrary
  class Error < RuntimeError
  end

  class WidgetError < Error
  end

  class FrobError < Error
  end

end
```

To handle both WidgetError and FrobError the library user can rescue
MyLibrary::Error.

The built-in subclasses of Exception are:

* NoMemoryError
* ScriptError
  * LoadError
  * NotImplementedError
  * SyntaxError

* SecurityError
* SignalException
  * Interrupt

* StandardError -- default for `rescue`
  * ArgumentError
    * UncaughtThrowError
  
  * EncodingError
  * FiberError
  * IOError
    * EOFError
  
  * IndexError
    * KeyError
    * StopIteration
  
  * LocalJumpError
  * NameError
    * NoMethodError
  
  * RangeError
    * FloatDomainError
  
  * RegexpError
  * RuntimeError -- default for `raise`
  * SystemCallError
    * Errno::\*
  
  * ThreadError
  * TypeError
  * ZeroDivisionError

* SystemExit
* SystemStackError
* fatal -- impossible to rescue

<a href='http://ruby-doc.org/core-2.5.0/Exception.html' class='ruby-doc
remote reference' target='_blank'>Exception Reference</a>

