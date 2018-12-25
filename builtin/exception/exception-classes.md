---
title: Exception Classes
prev: "/builtin/exception.html"
next: "/builtin/warning.html"
---

## Built-in Exception Classes[](#built-in-exception-classes)



### NoMemoryError[](#nomemoryerror)

Raised when memory allocation fails.

<a href='https://ruby-doc.org/core-2.5.0/NoMemoryError.html'
class='ruby-doc remote' target='_blank'>NoMemoryError Reference</a>



### ScriptError[](#scripterror)

ScriptError is the superclass for errors raised when a script can not be
executed because of a `LoadError`, `NotImplementedError` or a
`SyntaxError`. Note these type of `ScriptErrors` are not `StandardError`
and will not be rescued unless it is specified explicitly (or its
ancestor `Exception`).

<a href='https://ruby-doc.org/core-2.5.0/ScriptError.html'
class='ruby-doc remote' target='_blank'>ScriptError Reference</a>



### LoadError[](#loaderror)

Raised when a file required (a Ruby script, extension library, ...)
fails to load.


```ruby
require 'this/file/does/not/exist'
```

*raises the exception:*


```
LoadError: no such file to load -- this/file/does/not/exist
```

<a href='https://ruby-doc.org/core-2.5.0/LoadError.html' class='ruby-doc
remote' target='_blank'>LoadError Reference</a>



### NotImplementedError[](#notimplementederror)

Raised when a feature is not implemented on the current platform. For
example, methods depending on the `fsync` or `fork` system calls may
raise this exception if the underlying operating system or Ruby runtime
does not support them.

Note that if `fork` raises a `NotImplementedError`, then
`respond_to?(:fork)` returns `false`.

<a href='https://ruby-doc.org/core-2.5.0/NotImplementedError.html'
class='ruby-doc remote' target='_blank'>NotImplementedError
Reference</a>



### SyntaxError[](#syntaxerror)

Raised when encountering Ruby code with an invalid syntax.


```ruby
eval("1+1=2")
```

*raises the exception:*


```
SyntaxError: (eval):1: syntax error, unexpected '=', expecting $end
```

<a href='https://ruby-doc.org/core-2.5.0/SyntaxError.html'
class='ruby-doc remote' target='_blank'>SyntaxError Reference</a>



### SecurityError[](#securityerror)

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


```
SecurityError: Insecure: Insecure operation `untaint` at level 3
```

<a href='https://ruby-doc.org/core-2.5.0/SecurityError.html'
class='ruby-doc remote' target='_blank'>SecurityError Reference</a>



### SignalException[](#signalexception)

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

<a href='https://ruby-doc.org/core-2.5.0/SignalException.html'
class='ruby-doc remote' target='_blank'>SignalException Reference</a>



### Interrupt[](#interrupt)

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


```
Press ctrl-C when you get bored
```

*then waits until it is interrupted with Control-C and then prints:*


```
Note: You will typically use Signal.trap instead.
```

<a href='https://ruby-doc.org/core-2.5.0/Interrupt.html' class='ruby-doc
remote' target='_blank'>Interrupt Reference</a>



### StandardError[](#standarderror)

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


```
LoadError: no such file to load -- does/not/exist
```

<a href='https://ruby-doc.org/core-2.5.0/StandardError.html'
class='ruby-doc remote' target='_blank'>StandardError Reference</a>



### ArgumentError[](#argumenterror)

Raised when the arguments are wrong and there isn't a more specific
Exception class.

Ex: passing the wrong number of arguments


```ruby
[1, 2, 3].first(4, 5)
```

*raises the exception:*


```
ArgumentError: wrong number of arguments (given 2, expected 1)
```

Ex: passing an argument that is not acceptable:


```ruby
[1, 2, 3].first(-4)
```

*raises the exception:*


```
ArgumentError: negative array size
```

<a href='https://ruby-doc.org/core-2.5.0/ArgumentError.html'
class='ruby-doc remote' target='_blank'>ArgumentError Reference</a>



#### UncaughtThrowError[](#uncaughtthrowerror)

Raised when `throw` is called with a *tag* which does not have
corresponding `catch` block.


```ruby
throw "foo", "bar"
```

*raises the exception:*


```
UncaughtThrowError: uncaught throw "foo"
```

<a href='https://ruby-doc.org/core-2.5.0/UncaughtThrowError.html'
class='ruby-doc remote' target='_blank'>UncaughtThrowError Reference</a>



### EncodingError[](#encodingerror)

EncodingError is the base class for encoding errors.

<a href='https://ruby-doc.org/core-2.5.0/EncodingError.html'
class='ruby-doc remote' target='_blank'>EncodingError Reference</a>



### FiberError[](#fibererror)

Raised when an invalid operation is attempted on a Fiber, in particular
when attempting to call/resume a dead fiber, attempting to yield from
the root fiber, or calling a fiber across threads.


```ruby
fiber = Fiber.new{}
fiber.resume #=> nil
fiber.resume #=> FiberError: dead fiber called
```

<a href='https://ruby-doc.org/core-2.5.0/FiberError.html'
class='ruby-doc remote' target='_blank'>FiberError Reference</a>



### IOError[](#ioerror)

Raised when an IO operation fails.


```ruby
File.open("/etc/hosts") {|f| f << "example"}
  #=> IOError: not opened for writing

File.open("/etc/hosts") {|f| f.close; f.read }
  #=> IOError: closed stream
```

Note that some IO failures raise \`SystemCallError's and these are not
subclasses of IOError:


```ruby
File.open("does/not/exist")
  #=> Errno::ENOENT: No such file or directory - does/not/exist
```

<a href='https://ruby-doc.org/core-2.5.0/IOError.html' class='ruby-doc
remote' target='_blank'>IOError Reference</a>



#### EOFError[](#eoferror)

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

<a href='https://ruby-doc.org/core-2.5.0/EOFError.html' class='ruby-doc
remote' target='_blank'>EOFError Reference</a>



### IndexError[](#indexerror)

Raised when the given index is invalid.


```ruby
a = [:foo, :bar]
a.fetch(0)   #=> :foo
a[4]         #=> nil
a.fetch(4)   #=> IndexError: index 4 outside of array bounds: -2...2
```

<a href='https://ruby-doc.org/core-2.5.0/IndexError.html'
class='ruby-doc remote' target='_blank'>IndexError Reference</a>



#### KeyError[](#keyerror)

Raised when the specified key is not found. It is a subclass of
IndexError.


```ruby
h = {"foo" => :bar}
h.fetch("foo") #=> :bar
h.fetch("baz") #=> KeyError: key not found: "baz"
```

<a href='https://ruby-doc.org/core-2.5.0/KeyError.html' class='ruby-doc
remote' target='_blank'>KeyError Reference</a>



#### StopIteration[](#stopiteration)

Raised to stop the iteration, in particular by `Enumerator#next`. It is
rescued by `Kernel#loop`.


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

<a href='https://ruby-doc.org/core-2.5.0/StopIteration.html'
class='ruby-doc remote' target='_blank'>StopIteration Reference</a>



### LocalJumpError[](#localjumperror)

Raised when Ruby can't yield as requested.

A typical scenario is attempting to yield when no block is given:


```ruby
def call_block
  yield 42
end
call_block
```

*raises the exception:*


```
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


```
LocalJumpError: unexpected return
```

<a href='https://ruby-doc.org/core-2.5.0/LocalJumpError.html'
class='ruby-doc remote' target='_blank'>LocalJumpError Reference</a>



### NameError[](#nameerror)

Raised when a given name is invalid or undefined.


```ruby
puts foo
```

*raises the exception:*


```
NameError: undefined local variable or method `foo` for main:Object
```

Since constant names must start with a capital:


```ruby
Integer.const_set :answer, 42
```

*raises the exception:*


```
NameError: wrong constant name answer
```

<a href='https://ruby-doc.org/core-2.5.0/NameError.html' class='ruby-doc
remote' target='_blank'>NameError Reference</a>



#### NoMethodError[](#nomethoderror)

Raised when a method is called on a receiver which doesn't have it
defined and also fails to respond with `method_missing`.


```ruby
"hello".to_ary
```

*raises the exception:*


```
NoMethodError: undefined method `to_ary` for "hello":String
```

<a href='https://ruby-doc.org/core-2.5.0/NoMethodError.html'
class='ruby-doc remote' target='_blank'>NoMethodError Reference</a>



### RangeError[](#rangeerror)

Raised when a given numerical value is out of range.


```ruby
[1, 2, 3].drop(1 << 100)
```

*raises the exception:*


```
RangeError: bignum too big to convert into `long`
```

<a href='https://ruby-doc.org/core-2.5.0/RangeError.html'
class='ruby-doc remote' target='_blank'>RangeError Reference</a>



#### FloatDomainError[](#floatdomainerror)

Raised when attempting to convert special float values (in particular
`Infinity` or `NaN`) to numerical classes which don't support them.


```ruby
Float::INFINITY.to_r   #=> FloatDomainError: Infinity
```

<a href='https://ruby-doc.org/core-2.5.0/FloatDomainError.html'
class='ruby-doc remote' target='_blank'>FloatDomainError Reference</a>



### RegexpError[](#regexperror)

Raised when given an invalid regexp expression.


```ruby
Regexp.new("?")
```

*raises the exception:*


```
RegexpError: target of repeat operator is not specified: /?/
```

<a href='https://ruby-doc.org/core-2.5.0/RegexpError.html'
class='ruby-doc remote' target='_blank'>RegexpError Reference</a>



### RuntimeError[](#runtimeerror)

A generic error class raised when an invalid operation is attempted.
Kernel#raise will raise a RuntimeError if no Exception class is
specified.


```ruby
raise "ouch"
```

*raises the exception:*


```
RuntimeError: ouch
```

<a href='https://ruby-doc.org/core-2.5.0/RuntimeError.html'
class='ruby-doc remote' target='_blank'>RuntimeError Reference</a>



#### FrozenError[](#frozenerror)

Raised when there is an attempt to modify a frozen object.


```ruby
[1, 2, 3].freeze << 4
```

*raises the exception:*


```
FrozenError: can't modify frozen Array
```

<a href='https://ruby-doc.org/core-2.5.0/FrozenError.html'
class='ruby-doc remote' target='_blank'>FrozenError Reference</a>



### SystemCallError[](#systemcallerror)

SystemCallError is the base class for all low-level platform-dependent
errors.

The errors available on the current platform are subclasses of
SystemCallError and are defined in the Errno module.


```ruby
File.open("does/not/exist")
```

*raises the exception:*


```
Errno::ENOENT: No such file or directory - does/not/exist
```

<a href='https://ruby-doc.org/core-2.5.0/SystemCallError.html'
class='ruby-doc remote' target='_blank'>SystemCallError Reference</a>



#### Errno[](#errno)

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

<a href='https://ruby-doc.org/core-2.5.0/Errno.html' class='ruby-doc
remote' target='_blank'>Errno Reference</a>



### ThreadError[](#threaderror)

Raised when an invalid operation is attempted on a thread.

For example, when no other thread has been started:


```ruby
Thread.stop
```

This will raises the following exception:


```
ThreadError: stopping only thread
note: use sleep to stop forever
```

<a href='https://ruby-doc.org/core-2.5.0/ThreadError.html'
class='ruby-doc remote' target='_blank'>ThreadError Reference</a>



### TypeError[](#typeerror)

Raised when encountering an object that is not of the expected type.


```ruby
[1, 2, 3].first("two")
```

*raises the exception:*


```
TypeError: no implicit conversion of String into Integer
```

<a href='https://ruby-doc.org/core-2.5.0/TypeError.html' class='ruby-doc
remote' target='_blank'>TypeError Reference</a>



### ZeroDivisionError[](#zerodivisionerror)

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

<a href='https://ruby-doc.org/core-2.5.0/ZeroDivisionError.html'
class='ruby-doc remote' target='_blank'>ZeroDivisionError Reference</a>



### SystemExit[](#systemexit)

Raised by `exit` to initiate the termination of the script.

<a href='https://ruby-doc.org/core-2.5.0/SystemExit.html'
class='ruby-doc remote' target='_blank'>SystemExit Reference</a>



### SystemStackError[](#systemstackerror)

Raised in case of a stack overflow.


```ruby
def me_myself_and_i
  me_myself_and_i
end
me_myself_and_i
```

*raises the exception:*


```
SystemStackError: stack level too deep
```

<a href='https://ruby-doc.org/core-2.5.0/SystemStackError.html'
class='ruby-doc remote' target='_blank'>SystemStackError Reference</a>



### fatal[](#fatal)

fatal is an Exception that is raised when Ruby has encountered a fatal
error and must exit. You are not able to rescue fatal.

<a href='https://ruby-doc.org/core-2.5.0/fatal.html' class='ruby-doc
remote' target='_blank'>fatal Reference</a>

