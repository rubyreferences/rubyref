---
title: 'Appendix A: Kernel methods list'
prev: "/advanced/contributing.html"
next: "/appendix-b.html"
---

## Appendix A: Kernel methods list



* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-callcc'
  class='ruby-doc remote' target='_blank'>callcc</a>\: Generates a
  Continuation object, which it passes to the associated block.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-eval'
  class='ruby-doc remote' target='_blank'>eval</a>\: Evaluates the Ruby
  expression(s) in *string*.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-lambda'
  class='ruby-doc remote' target='_blank'>lambda</a>\: Equivalent to
  `Proc.new`, except the resulting Proc objects check the number of
  parameters passed when called.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-proc'
  class='ruby-doc remote' target='_blank'>proc</a>\: Equivalent to
  `Proc.new`.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-rand'
  class='ruby-doc remote' target='_blank'>rand</a>\: If called without
  an argument, or if `max.to_i.abs == 0`, rand returns a pseudo-random
  floating point number between 0.0 and 1.0, including 0.0 and excluding
  1.0.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-srand'
  class='ruby-doc remote' target='_blank'>srand</a>\: Seeds the system
  pseudo-random number generator, Random::DEFAULT, with `number`.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-warn'
  class='ruby-doc remote' target='_blank'>warn</a>\: If warnings have
  been disabled (for example with the `-W0` flag), does nothing.

### Loading Code

* <a
  href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-autoload'
  class='ruby-doc remote' target='_blank'>autoload</a>\: Registers
  *filename* to be loaded (using `Kernel::require`) the first time that
  *module* (which may be a `String` or a symbol) is accessed.
* <a
  href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-autoload-3F'
  class='ruby-doc remote' target='_blank'>autoload?</a>\: Returns
  *filename* to be loaded if *name* is registered as `autoload`.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-load'
  class='ruby-doc remote' target='_blank'>load</a>\: Loads and executes
  the Ruby program in the file *filename*.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-require'
  class='ruby-doc remote' target='_blank'>require</a>\: Loads the given
  `name`, returning `true` if successful and `false` if the feature is
  already loaded.
* <a
  href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-require_relative'
  class='ruby-doc remote' target='_blank'>require_relative</a>\: Ruby
  tries to load the library named *string* relative to the requiring
  file's path.
^

* <a
  href='https://ruby-doc.org/stdlib-2.5.0/libdoc/rubygems/rdoc/Kernel.html#method-i-gem'
  class='ruby-doc remote' target='_blank'>gem</a> *(defined by
  RubyGems)*\: Use `#gem` to activate a specific version of gem\_name.

### Data Conversion

* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-Array'
  class='ruby-doc remote' target='_blank'>Array</a>\: Returns `arg` as
  an Array.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-Complex'
  class='ruby-doc remote' target='_blank'>Complex</a>\: Returns x+i\*y;
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-Float'
  class='ruby-doc remote' target='_blank'>Float</a>\:
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-Hash'
  class='ruby-doc remote' target='_blank'>Hash</a>\: Converts *arg* to a
  `Hash` by calling *arg*`.to_hash`.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-Integer'
  class='ruby-doc remote' target='_blank'>Integer</a>\: Converts *arg*
  to an `Integer`.
* <a
  href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-Rational'
  class='ruby-doc remote' target='_blank'>Rational</a>\: Returns `x/y`
  or `arg` as a Rational.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-String'
  class='ruby-doc remote' target='_blank'>String</a>\: Returns *arg* as
  a `String`.

### Current Context

* <a
  href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-__callee__'
  class='ruby-doc remote' target='_blank'>__callee__</a>\: Returns the
  called name of the current method as a Symbol.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-__dir__'
  class='ruby-doc remote' target='_blank'>__dir__</a>\: Returns the
  canonicalized absolute path of the directory of the file from which
  this method is called.
* <a
  href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-__method__'
  class='ruby-doc remote' target='_blank'>__method__</a>\: Returns the
  name at the definition of the current method as a Symbol.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-binding'
  class='ruby-doc remote' target='_blank'>binding</a>\: Returns a
  `Binding` object, describing the variable and method bindings at the
  point of call.
* <a
  href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-block_given-3F'
  class='ruby-doc remote' target='_blank'>block_given?</a>\: Returns
  `true` if `yield` would execute a block in the current context.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-caller'
  class='ruby-doc remote' target='_blank'>caller</a>\: Returns the
  current execution stack—an array containing strings in the form
  `file:line` or `file:line: in `method'\`.
* <a
  href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-caller_locations'
  class='ruby-doc remote' target='_blank'>caller_locations</a>\: Returns
  the current execution stack—an array containing backtrace location
  objects.
* <a
  href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-global_variables'
  class='ruby-doc remote' target='_blank'>global_variables</a>\: Returns
  an array of the names of global variables.
* <a
  href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-local_variables'
  class='ruby-doc remote' target='_blank'>local_variables</a>\: Returns
  the names of the current local variables.

### Execution Flow

* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-abort'
  class='ruby-doc remote' target='_blank'>abort</a>\: Terminate
  execution immediately, effectively by calling `Kernel.exit(false)`.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-at_exit'
  class='ruby-doc remote' target='_blank'>at_exit</a>\: Converts *block*
  to a `Proc` object (and therefore binds it at the point of call) and
  registers it for execution when the program exits.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-catch'
  class='ruby-doc remote' target='_blank'>catch</a>\: `catch` executes
  its block.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-exit'
  class='ruby-doc remote' target='_blank'>exit</a>\: Initiates the
  termination of the Ruby script by raising the `SystemExit` exception.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-exit-21'
  class='ruby-doc remote' target='_blank'>exit!</a>\: Exits the process
  immediately.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-fail'
  class='ruby-doc remote' target='_blank'>fail</a>\: With no arguments,
  raises the exception in `$!` or raises a `RuntimeError` if `$!` is
  `nil`.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-loop'
  class='ruby-doc remote' target='_blank'>loop</a>\: Repeatedly executes
  the block.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-raise'
  class='ruby-doc remote' target='_blank'>raise</a>\: With no arguments,
  raises the exception in `$!` or raises a `RuntimeError` if `$!` is
  `nil`.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-sleep'
  class='ruby-doc remote' target='_blank'>sleep</a>\: Suspends the
  current thread for *duration* seconds (which may be any number,
  including a `Float` with fractional seconds).
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-throw'
  class='ruby-doc remote' target='_blank'>throw</a>\: Transfers control
  to the end of the active `catch` block waiting for *tag*.

### IO and Strings

* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-format'
  class='ruby-doc remote' target='_blank'>format</a>\: Returns the
  string resulting from applying *format\_string* to any additional
  arguments.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-gets'
  class='ruby-doc remote' target='_blank'>gets</a>\: Returns (and
  assigns to `$_`) the next line from the list of files in `ARGV` (or
  `$*`), or from standard input if no files are present on the command
  line.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-p'
  class='ruby-doc remote' target='_blank'>p</a>\: For each object,
  directly writes *obj*.`inspect` followed by a newline to the program's
  standard output.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-print'
  class='ruby-doc remote' target='_blank'>print</a>\: Prints each object
  in turn to `$stdout`.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-printf'
  class='ruby-doc remote' target='_blank'>printf</a>\: Equivalent to:
  io.write(sprintf(string, obj, ...)) or $stdout.write(sprintf(string,
  obj, ...))
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-putc'
  class='ruby-doc remote' target='_blank'>putc</a>\: Equivalent to:
  $stdout.putc(int) Refer to the documentation for `IO#putc` for
  important information regarding multi-byte characters.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-puts'
  class='ruby-doc remote' target='_blank'>puts</a>\: Equivalent to
  $stdout.puts(obj, ...)
* <a
  href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-readline'
  class='ruby-doc remote' target='_blank'>readline</a>\: Equivalent to
  `Kernel::gets`, except `readline` raises `EOFError` at end of file.
* <a
  href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-readlines'
  class='ruby-doc remote' target='_blank'>readlines</a>\: Returns an
  array containing the lines returned by calling `Kernel.gets(*sep*)`
  until the end of file.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-sprintf'
  class='ruby-doc remote' target='_blank'>sprintf</a>\: Returns the
  string resulting from applying *format\_string* to any additional
  arguments.

### Files

* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-open'
  class='ruby-doc remote' target='_blank'>open</a>\: Creates an IO
  object connected to the given stream, file, or subprocess.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-select'
  class='ruby-doc remote' target='_blank'>select</a>\: Calls select(2)
  system call.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-test'
  class='ruby-doc remote' target='_blank'>test</a>\: Uses the character
  `cmd` to perform various tests on `file1` (first table below) or on
  `file1` and `file2` (second table).

### Tracing Execution

* <a
  href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-set_trace_func'
  class='ruby-doc remote' target='_blank'>set_trace_func</a>\:
  Establishes *proc* as the handler for tracing, or disables tracing if
  the parameter is `nil`.
* <a
  href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-trace_var'
  class='ruby-doc remote' target='_blank'>trace_var</a>\: Controls
  tracing of assignments to global variables.
* <a
  href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-untrace_var'
  class='ruby-doc remote' target='_blank'>untrace_var</a>\: Removes
  tracing for the specified command on the given global variable and
  returns `nil`.

### Processes and Commands

* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-60'
  class='ruby-doc remote' target='_blank'>`</a>\: Returns the standard
  output of running *cmd* in a subshell.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-exec'
  class='ruby-doc remote' target='_blank'>exec</a>\: Replaces the
  current process by running the given external *command*.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-fork'
  class='ruby-doc remote' target='_blank'>fork</a>\: Creates a
  subprocess.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-spawn'
  class='ruby-doc remote' target='_blank'>spawn</a>\: spawn executes
  specified command and return its pid.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-syscall'
  class='ruby-doc remote' target='_blank'>syscall</a>\: Calls the
  operating system function identified by *num* and returns the result
  of the function or raises SystemCallError if it failed.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-system'
  class='ruby-doc remote' target='_blank'>system</a>\: Executes
  *command...* in a subshell.
* <a href='https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-trap'
  class='ruby-doc remote' target='_blank'>trap</a>\: Specifies the
  handling of signals.

