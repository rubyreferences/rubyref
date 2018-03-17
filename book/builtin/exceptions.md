# Exception

Descendants of class Exception are used to communicate between
Kernel#raise and `rescue` statements in `begin ... end` blocks.
Exception objects carry information about the exception -- its type (the
exception's class name), an optional descriptive string, and optional
traceback information. Exception subclasses may add additional
information like NameError#name.

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
    * FrozenError
  
  * SystemCallError
    * Errno::\*
  
  * ThreadError
  * TypeError
  * ZeroDivisionError

* SystemExit
* SystemStackError
* fatal -- impossible to rescue



## NoMemoryError

Raised when memory allocation fails.



## ScriptError

ScriptError is the superclass for errors raised when a script can not be
executed because of a `LoadError`, `NotImplementedError` or a
`SyntaxError`. Note these type of `ScriptErrors` are not `StandardError`
and will not be rescued unless it is specified explicitly (or its
ancestor `Exception`).



### LoadError

Raised when a file required (a Ruby script, extension library, ...)
fails to load.


```ruby
require 'this/file/does/not/exist'
```

*raises the exception:*


```ruby
LoadError: no such file to load -- this/file/does/not/exist
```



### NotImplementedError

Raised when a feature is not implemented on the current platform. For
example, methods depending on the `fsync` or `fork` system calls may
raise this exception if the underlying operating system or Ruby runtime
does not support them.

Note that if `fork` raises a `NotImplementedError`, then
`respond_to?(:fork)` returns `false`.



### SyntaxError

Raised when encountering Ruby code with an invalid syntax.


```ruby
eval("1+1=2")
```

*raises the exception:*


```ruby
SyntaxError: (eval):1: syntax error, unexpected '=', expecting $end
```



## SecurityError

Raised when attempting a potential unsafe operation, typically when the
$SAFE level is raised above 0.


```ruby
foo = "bar"
proc = Proc.new do
  $SAFE = 3
  foo.untaint
end
proc.call
```

*raises the exception:*


```ruby
SecurityError: Insecure: Insecure operation `untaint' at level 3
```



## SignalException

Raised when a signal is received.


```ruby
begin
  Process.kill('HUP',Process.pid)
  sleep # wait for receiver to handle signal sent by Process.kill
rescue SignalException => e
  puts "received Exception #{e}"
end
```

*produces:*


```ruby
received Exception SIGHUP
```



### Interrupt

Raised with the interrupt signal is received, typically because the user
pressed on Control-C (on most posix platforms). As such, it is a
subclass of `SignalException`.


```ruby
begin
  puts "Press ctrl-C when you get bored"
  loop {}
rescue Interrupt => e
  puts "Note: You will typically use Signal.trap instead."
end
```

*produces:*


```ruby
Press ctrl-C when you get bored
```

*then waits until it is interrupted with Control-C and then prints:*


```ruby
Note: You will typically use Signal.trap instead.
```



## StandardError

The most standard error types are subclasses of StandardError. A rescue
clause without an explicit Exception class will rescue all
StandardErrors (and only those).


```ruby
def foo
  raise "Oups"
end
foo rescue "Hello"   #=> "Hello"
```

On the other hand:


```ruby
require 'does/not/exist' rescue "Hi"
```

*raises the exception:*


```ruby
LoadError: no such file to load -- does/not/exist
```



### ArgumentError

Raised when the arguments are wrong and there isn't a more specific
Exception class.

Ex: passing the wrong number of arguments


```ruby
[1, 2, 3].first(4, 5)
```

*raises the exception:*


```ruby
ArgumentError: wrong number of arguments (given 2, expected 1)
```

Ex: passing an argument that is not acceptable:


```ruby
[1, 2, 3].first(-4)
```

*raises the exception:*


```ruby
ArgumentError: negative array size
```



#### UncaughtThrowError

Raised when `throw` is called with a *tag* which does not have
corresponding `catch` block.


```ruby
throw "foo", "bar"
```

*raises the exception:*


```ruby
UncaughtThrowError: uncaught throw "foo"
```



### EncodingError

EncodingError is the base class for encoding errors.



### FiberError

Raised when an invalid operation is attempted on a Fiber, in particular
when attempting to call/resume a dead fiber, attempting to yield from
the root fiber, or calling a fiber across threads.


```ruby
fiber = Fiber.new{}
fiber.resume #=> nil
fiber.resume #=> FiberError: dead fiber called
```



### IOError

Raised when an IO operation fails.


```ruby
File.open("/etc/hosts") {|f| f << "example"}
  #=> IOError: not opened for writing

File.open("/etc/hosts") {|f| f.close; f.read }
  #=> IOError: closed stream
```

Note that some IO failures raise `SystemCallError`s and these are not
subclasses of IOError:


```ruby
File.open("does/not/exist")
  #=> Errno::ENOENT: No such file or directory - does/not/exist
```



#### EOFError

Raised by some IO operations when reaching the end of file. Many IO
methods exist in two forms,

one that returns `nil` when the end of file is reached, the other raises
`EOFError`.

`EOFError` is a subclass of `IOError`.


```ruby
file = File.open("/etc/hosts")
file.read
file.gets     #=> nil
file.readline #=> EOFError: end of file reached
```



### IndexError

Raised when the given index is invalid.


```ruby
a = [:foo, :bar]
a.fetch(0)   #=> :foo
a[4]         #=> nil
a.fetch(4)   #=> IndexError: index 4 outside of array bounds: -2...2
```



#### KeyError

Raised when the specified key is not found. It is a subclass of
IndexError.


```ruby
h = {"foo" => :bar}
h.fetch("foo") #=> :bar
h.fetch("baz") #=> KeyError: key not found: "baz"
```



#### StopIteration

Raised to stop the iteration, in particular by Enumerator#next. It is
rescued by Kernel#loop.


```ruby
loop do
  puts "Hello"
  raise StopIteration
  puts "World"
end
puts "Done!"
```

*produces:*


```ruby
Hello
Done!
```



### LocalJumpError

Raised when Ruby can't yield as requested.

A typical scenario is attempting to yield when no block is given:


```ruby
def call_block
  yield 42
end
call_block
```

*raises the exception:*


```ruby
LocalJumpError: no block given (yield)
```

A more subtle example:


```ruby
def get_me_a_return
  Proc.new { return 42 }
end
get_me_a_return.call
```

*raises the exception:*


```ruby
LocalJumpError: unexpected return
```



### NameError

Raised when a given name is invalid or undefined.


```ruby
puts foo
```

*raises the exception:*


```ruby
NameError: undefined local variable or method `foo' for main:Object
```

Since constant names must start with a capital:


```ruby
Integer.const_set :answer, 42
```

*raises the exception:*


```ruby
NameError: wrong constant name answer
```



#### NoMethodError

Raised when a method is called on a receiver which doesn't have it
defined and also fails to respond with `method_missing`.


```ruby
"hello".to_ary
```

*raises the exception:*


```ruby
NoMethodError: undefined method `to_ary' for "hello":String
```



### RangeError

Raised when a given numerical value is out of range.


```ruby
[1, 2, 3].drop(1 << 100)
```

*raises the exception:*


```ruby
RangeError: bignum too big to convert into `long'
```



#### FloatDomainError

Raised when attempting to convert special float values (in particular
`Infinity` or `NaN`) to numerical classes which don't support them.


```ruby
Float::INFINITY.to_r   #=> FloatDomainError: Infinity
```



### RegexpError

Raised when given an invalid regexp expression.


```ruby
Regexp.new("?")
```

*raises the exception:*


```ruby
RegexpError: target of repeat operator is not specified: /?/
```



### RuntimeError

A generic error class raised when an invalid operation is attempted.
Kernel#raise will raise a RuntimeError if no Exception class is
specified.


```ruby
raise "ouch"
```

*raises the exception:*


```ruby
RuntimeError: ouch
```



#### FrozenError

Raised when there is an attempt to modify a frozen object.


```ruby
[1, 2, 3].freeze << 4
```

*raises the exception:*


```ruby
FrozenError: can't modify frozen Array
```



### SystemCallError

SystemCallError is the base class for all low-level platform-dependent
errors.

The errors available on the current platform are subclasses of
SystemCallError and are defined in the Errno module.


```ruby
File.open("does/not/exist")
```

*raises the exception:*


```ruby
Errno::ENOENT: No such file or directory - does/not/exist
```



#### Errno

Ruby exception objects are subclasses of `Exception`. However, operating
systems typically report errors using plain integers. Module `Errno` is
created dynamically to map these operating system errors to Ruby
classes, with each error number generating its own subclass of
`SystemCallError`. As the subclass is created in module `Errno`, its
name will start `Errno::`.

The names of the `Errno::` classes depend on the environment in which
Ruby runs. On a typical Unix or Windows platform, there are `Errno`
classes such as `Errno::EACCES`, `Errno::EAGAIN`, `Errno::EINTR`, and so
on.

The integer operating system error number corresponding to a particular
error is available as the class constant `Errno::`*error*`::Errno`.


```ruby
Errno::EACCES::Errno   #=> 13
Errno::EAGAIN::Errno   #=> 11
Errno::EINTR::Errno    #=> 4
```

The full list of operating system errors on your particular platform are
available as the constants of `Errno`.


```ruby
Errno.constants   #=> :E2BIG, :EACCES, :EADDRINUSE, :EADDRNOTAVAIL, ...
```



### ThreadError

Raised when an invalid operation is attempted on a thread.

For example, when no other thread has been started:


```ruby
Thread.stop
```

This will raises the following exception:


```ruby
ThreadError: stopping only thread
note: use sleep to stop forever
```



### TypeError

Raised when encountering an object that is not of the expected type.


```ruby
[1, 2, 3].first("two")
```

*raises the exception:*


```ruby
TypeError: no implicit conversion of String into Integer
```



### ZeroDivisionError

Raised when attempting to divide an integer by 0.


```ruby
42 / 0   #=> ZeroDivisionError: divided by 0
```

Note that only division by an exact 0 will raise the exception:


```ruby
42 /  0.0   #=> Float::INFINITY
42 / -0.0   #=> -Float::INFINITY
0  /  0.0   #=> NaN
```



## SystemExit

Raised by `exit` to initiate the termination of the script.



## SystemStackError

Raised in case of a stack overflow.


```ruby
def me_myself_and_i
  me_myself_and_i
end
me_myself_and_i
```

*raises the exception:*


```ruby
SystemStackError: stack level too deep
```



## fatal

fatal is an Exception that is raised when Ruby has encountered a fatal
error and must exit. You are not able to rescue fatal.

