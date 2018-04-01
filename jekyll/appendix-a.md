---
title: 'Appendix A: Kernel methods list'
prev: "/advanced/contributing.html"
next: "/appendix-b.html"
---

## Appendix A: Kernel methods list



* [callcc](ref:`Kernel#callcc`)\: Generates a Continuation object, which
  it passes to the associated block.
* [eval](ref:`Kernel#eval`)\: Evaluates the Ruby expression(s) in
  *string*.
* [lambda](ref:`Kernel#lambda`)\: Equivalent to `Proc.new`, except the
  resulting Proc objects check the number of parameters passed when
  called.
* [proc](ref:`Kernel#proc`)\: Equivalent to `Proc.new`.
* [rand](ref:`Kernel#rand`)\: If called without an argument, or if
  `max.to_i.abs == 0`, rand returns a pseudo-random floating point
  number between 0.0 and 1.0, including 0.0 and excluding 1.0.
* [srand](ref:`Kernel#srand`)\: Seeds the system pseudo-random number
  generator, Random::DEFAULT, with `number`.
* [warn](ref:`Kernel#warn`)\: If warnings have been disabled (for
  example with the `-W0` flag), does nothing.

### Loading Code

* [autoload](ref:`Kernel#autoload`)\: Registers *filename* to be loaded
  (using `Kernel::require`) the first time that *module* (which may be a
  `String` or a symbol) is accessed.
* [autoload?](ref:`Kernel#autoload?`)\: Returns *filename* to be loaded
  if *name* is registered as `autoload`.
* [load](ref:`Kernel#load`)\: Loads and executes the Ruby program in the
  file *filename*.
* [require](ref:`Kernel#require`)\: Loads the given `name`, returning
  `true` if successful and `false` if the feature is already loaded.
* [require\_relative](ref:`Kernel#require_relative`)\: Ruby tries to
  load the library named *string* relative to the requiring file's path.
^

* [gem](ref:rubygems:Kernel#gem) *(defined by RubyGems)*\: Use `#gem` to
  activate a specific version of gem\_name.

### Data Conversion

* [Array](ref:Kernel#Array)\: Returns `arg` as an Array.
* [Complex](ref:Kernel#Complex)\: Returns x+i\*y;
* [Float](ref:Kernel#Float)\: Returns *arg* converted to a float.
* [Hash](ref:Kernel#Hash)\: Converts *arg* to a `Hash` by calling
  *arg*`.to_hash`.
* [Integer](ref:Kernel#Integer)\: Converts *arg* to an `Integer`.
* [Rational](ref:Kernel#Rational)\: Returns `x/y` or `arg` as a
  Rational.
* [String](ref:Kernel#String)\: Returns *arg* as a `String`.

### Current Context

* [\_\_callee\_\_](ref:`Kernel#__callee__`)\: Returns the called name of
  the current method as a Symbol.
* [\_\_dir\_\_](ref:`Kernel#__dir__`)\: Returns the canonicalized
  absolute path of the directory of the file from which this method is
  called.
* [\_\_method\_\_](ref:`Kernel#__method__`)\: Returns the name at the
  definition of the current method as a Symbol.
* [binding](ref:`Kernel#binding`)\: Returns a `Binding` object,
  describing the variable and method bindings at the point of call.
* [block\_given?](ref:`Kernel#block_given?`)\: Returns `true` if `yield`
  would execute a block in the current context.
* [caller](ref:`Kernel#caller`)\: Returns the current execution stack—an
  array containing strings in the form `file:line` or `file:line: in
  `method'\`.
* [caller\_locations](ref:`Kernel#caller_locations`)\: Returns the
  current execution stack—an array containing backtrace location
  objects.
* [global\_variables](ref:`Kernel#global_variables`)\: Returns an array
  of the names of global variables.
* [local\_variables](ref:`Kernel#local_variables`)\: Returns the names
  of the current local variables.

### Execution Flow

* [abort](ref:`Kernel#abort`)\: Terminate execution immediately,
  effectively by calling `Kernel.exit(false)`.
* [at\_exit](ref:`Kernel#at_exit`)\: Converts *block* to a `Proc` object
  (and therefore binds it at the point of call) and registers it for
  execution when the program exits.
* [catch](ref:`Kernel#catch`)\: `catch` executes its block.
* [exit](ref:`Kernel#exit`)\: Initiates the termination of the Ruby
  script by raising the `SystemExit` exception.
* [exit!](ref:`Kernel#exit!`)\: Exits the process immediately.
* [fail](ref:`Kernel#fail`)\: With no arguments, raises the exception in
  `$!` or raises a `RuntimeError` if `$!` is `nil`.
* [loop](ref:`Kernel#loop`)\: Repeatedly executes the block.
* [raise](ref:`Kernel#raise`)\: With no arguments, raises the exception
  in `$!` or raises a `RuntimeError` if `$!` is `nil`.
* [sleep](ref:`Kernel#sleep`)\: Suspends the current thread for
  *duration* seconds (which may be any number, including a `Float` with
  fractional seconds).
* [throw](ref:`Kernel#throw`)\: Transfers control to the end of the
  active `catch` block waiting for *tag*.

### IO and Strings

* [format](ref:`Kernel#format`)\: Returns the string resulting from
  applying *format\_string* to any additional arguments.
* [gets](ref:`Kernel#gets`)\: Returns (and assigns to `$_`) the next
  line from the list of files in `ARGV` (or `$*`), or from standard
  input if no files are present on the command line.
* [p](ref:`Kernel#p`)\: For each object, directly writes *obj*.`inspect`
  followed by a newline to the program's standard output.
* [print](ref:`Kernel#print`)\: Prints each object in turn to `$stdout`.
* [printf](ref:`Kernel#printf`)\: Equivalent to:
  io.write(sprintf(string, obj, ...)) or $stdout.write(sprintf(string,
  obj, ...))
* [putc](ref:`Kernel#putc`)\: Equivalent to: $stdout.putc(int) Refer to
  the documentation for `IO#putc` for important information regarding
  multi-byte characters.
* [puts](ref:`Kernel#puts`)\: Equivalent to $stdout.puts(obj, ...)
* [readline](ref:`Kernel#readline`)\: Equivalent to `Kernel::gets`,
  except `readline` raises `EOFError` at end of file.
* [readlines](ref:`Kernel#readlines`)\: Returns an array containing the
  lines returned by calling `Kernel.gets(*sep*)` until the end of file.
* [sprintf](ref:`Kernel#sprintf`)\: Returns the string resulting from
  applying *format\_string* to any additional arguments.

### Files

* [open](ref:`Kernel#open`)\: Creates an IO object connected to the
  given stream, file, or subprocess.
* [select](ref:`Kernel#select`)\: Calls select(2) system call.
* [test](ref:`Kernel#test`)\: Uses the character `cmd` to perform
  various tests on `file1` (first table below) or on `file1` and `file2`
  (second table).

### Tracing Execution

* [set\_trace\_func](ref:`Kernel#set_trace_func`)\: Establishes *proc*
  as the handler for tracing, or disables tracing if the parameter is
  `nil`.
* [trace\_var](ref:`Kernel#trace_var`)\: Controls tracing of assignments
  to global variables.
* [untrace\_var](ref:`Kernel#untrace_var`)\: Removes tracing for the
  specified command on the given global variable and returns `nil`.

### Processes and Commands

* [\`](ref:Kernel#`)\: Returns the standard output of running *cmd* in a
  subshell.
* [exec](ref:`Kernel#exec`)\: Replaces the current process by running
  the given external *command*.
* [fork](ref:`Kernel#fork`)\: Creates a subprocess.
* [spawn](ref:`Kernel#spawn`)\: spawn executes specified command and
  return its pid.
* [syscall](ref:`Kernel#syscall`)\: Calls the operating system function
  identified by *num* and returns the result of the function or raises
  SystemCallError if it failed.
* [system](ref:`Kernel#system`)\: Executes *command...* in a subshell.
* [trap](ref:`Kernel#trap`)\: Specifies the handling of signals.

