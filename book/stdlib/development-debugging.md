# Development and Debuggin Tools

This section lists several tools that help developing in Ruby.



## Benchmark

The Benchmark module provides methods to measure and report the time
used to execute Ruby code.

* Measure the time to construct the string given by the expression
  `"a"*1_000_000_000`\:
  
  
  ```ruby
  require 'benchmark'
  
  puts Benchmark.measure { "a"*1_000_000_000 }
  ```
  
  On my machine (OSX 10.8.3 on i5 1.7 GHz) this generates:
  
  
  ```ruby
  0.350000   0.400000   0.750000 (  0.835234)
  ```
  
  This report shows the user CPU time, system CPU time, the sum of the
  user and system CPU times, and the elapsed real time. The unit of time
  is seconds.

* Do some experiments sequentially using the `#bm` method:
  
  
  ```ruby
  require 'benchmark'
  
  n = 5000000
  Benchmark.bm do |x|
    x.report { for i in 1..n; a = "1"; end }
    x.report { n.times do   ; a = "1"; end }
    x.report { 1.upto(n) do ; a = "1"; end }
  end
  ```
  
  The result:
  
  
  ```ruby
      user     system      total        real
  1.010000   0.000000   1.010000 (  1.014479)
  1.000000   0.000000   1.000000 (  0.998261)
  0.980000   0.000000   0.980000 (  0.981335)
  ```

* Continuing the previous example, put a label in each report:
  
  
  ```ruby
  require 'benchmark'
  
  n = 5000000
  Benchmark.bm(7) do |x|
    x.report("for:")   { for i in 1..n; a = "1"; end }
    x.report("times:") { n.times do   ; a = "1"; end }
    x.report("upto:")  { 1.upto(n) do ; a = "1"; end }
  end
  ```

The result:


```ruby
              user     system      total        real
for:      1.010000   0.000000   1.010000 (  1.015688)
times:    1.000000   0.000000   1.000000 (  1.003611)
upto:     1.030000   0.000000   1.030000 (  1.028098)
```

* The times for some benchmarks depend on the order in which items are
  run. These differences are due to the cost of memory allocation and
  garbage collection. To avoid these discrepancies, the #bmbm method is
  provided. For example, to compare ways to sort an array of floats:
  
  
  ```ruby
  require 'benchmark'
  
  array = (1..1000000).map { rand }
  
  Benchmark.bmbm do |x|
    x.report("sort!") { array.dup.sort! }
    x.report("sort")  { array.dup.sort  }
  end
  ```
  
  The result:
  
  
  ```ruby
  Rehearsal -----------------------------------------
  sort!   1.490000   0.010000   1.500000 (  1.490520)
  sort    1.460000   0.000000   1.460000 (  1.463025)
  -------------------------------- total: 2.960000sec
  
              user     system      total        real
  sort!   1.460000   0.000000   1.460000 (  1.460465)
  sort    1.450000   0.010000   1.460000 (  1.448327)
  ```

* Report statistics of sequential experiments with unique labels, using
  the #benchmark method:
  
  
  ```ruby
  require 'benchmark'
  include Benchmark         # we need the CAPTION and FORMAT constants
  
  n = 5000000
  Benchmark.benchmark(CAPTION, 7, FORMAT, ">total:", ">avg:") do |x|
    tf = x.report("for:")   { for i in 1..n; a = "1"; end }
    tt = x.report("times:") { n.times do   ; a = "1"; end }
    tu = x.report("upto:")  { 1.upto(n) do ; a = "1"; end }
    [tf+tt+tu, (tf+tt+tu)/3]
  end
  ```
  
  The result:
  
  
  ```ruby
               user     system      total        real
  for:      0.950000   0.000000   0.950000 (  0.952039)
  times:    0.980000   0.000000   0.980000 (  0.984938)
  upto:     0.950000   0.000000   0.950000 (  0.946787)
  >total:   2.880000   0.000000   2.880000 (  2.883764)
  >avg:     0.960000   0.000000   0.960000 (  0.961255)
  ```



## DEBUGGER\_\_

This library provides debugging functionality to Ruby.

To add a debugger to your code, start by requiring `debug` in your
program:


```ruby
def say(word)
  require 'debug'
  puts word
end
```

This will cause Ruby to interrupt execution and show a prompt when the
`say` method is run.

Once you're inside the prompt, you can start debugging your program.


```ruby
(rdb:1) p word
"hello"
```

### Getting help

You can get help at any time by pressing `h`.


```ruby
(rdb:1) h
Debugger help v.-0.002b
Commands
  b[reak] [file:|class:]<line|method>
  b[reak] [class.]<line|method>
                             set breakpoint to some position
  wat[ch] <expression>       set watchpoint to some expression
  cat[ch] (<exception>|off)  set catchpoint to an exception
  b[reak]                    list breakpoints
  cat[ch]                    show catchpoint
  del[ete][ nnn]             delete some or all breakpoints
  disp[lay] <expression>     add expression into display expression list
  undisp[lay][ nnn]          delete one particular or all display expressions
  c[ont]                     run until program ends or hit breakpoint
  s[tep][ nnn]               step (into methods) one line or till line nnn
  n[ext][ nnn]               go over one line or till line nnn
  w[here]                    display frames
  f[rame]                    alias for where
  l[ist][ (-|nn-mm)]         list program, - lists backwards
                             nn-mm lists given lines
  up[ nn]                    move to higher frame
  down[ nn]                  move to lower frame
  fin[ish]                   return to outer frame
  tr[ace] (on|off)           set trace mode of current thread
  tr[ace] (on|off) all       set trace mode of all threads
  q[uit]                     exit from debugger
  v[ar] g[lobal]             show global variables
  v[ar] l[ocal]              show local variables
  v[ar] i[nstance] <object>  show instance variables of object
  v[ar] c[onst] <object>     show constants of object
  m[ethod] i[nstance] <obj>  show methods of object
  m[ethod] <class|module>    show instance methods of class or module
  th[read] l[ist]            list all threads
  th[read] c[ur[rent]]       show current thread
  th[read] [sw[itch]] <nnn>  switch thread context to nnn
  th[read] stop <nnn>        stop thread nnn
  th[read] resume <nnn>      resume thread nnn
  p expression               evaluate expression and print its value
  h[elp]                     print this help
  <everything else>          evaluate
```

### Usage

The following is a list of common functionalities that the debugger
provides.

#### Navigating through your code

In general, a debugger is used to find bugs in your program, which often
means pausing execution and inspecting variables at some point in time.

Let's look at an example:


```ruby
def my_method(foo)
  require 'debug'
  foo = get_foo if foo.nil?
  raise if foo.nil?
end
```

When you run this program, the debugger will kick in just before the
`foo` assignment.


```ruby
(rdb:1) p foo
nil
```

In this example, it'd be interesting to move to the next line and
inspect the value of `foo` again. You can do that by pressing `n`\:


```ruby
(rdb:1) n # goes to next line
(rdb:1) p foo
nil
```

You now know that the original value of `foo` was nil, and that it still
was nil after calling `get_foo`.

Other useful commands for navigating through your code are:

* `c`\: Runs the program until it either exists or encounters another
  breakpoint. You usually press `c` when you are finished debugging your
  program and want to resume its execution.

* `s`\: Steps into method definition. In the previous example, `s` would
  take you inside the method definition of `get_foo`.

* `r`\: Restart the program.
* `q`\: Quit the program.

#### Inspecting variables

You can use the debugger to easily inspect both local and global
variables. We've seen how to inspect local variables before:


```ruby
(rdb:1) p my_arg
42
```

You can also pretty print the result of variables or expressions:


```ruby
(rdb:1) pp %w{a very long long array containing many words}
["a",
 "very",
 "long",
 ...
]
```

You can list all local variables with +v l+:


```ruby
(rdb:1) v l
  foo => "hello"
```

Similarly, you can show all global variables with +v g+:


```ruby
(rdb:1) v g
  all global variables
```

Finally, you can omit `p` if you simply want to evaluate a variable or
expression


```ruby
(rdb:1) 5**2
25
```

#### Going beyond basics

Ruby Debug provides more advanced functionalities like switching between
threads, setting breakpoints and watch expressions, and more. The full
list of commands is available at any time by pressing `h`.

### Staying out of trouble

Make sure you remove every instance of +require 'debug'+ before shipping
your code. Failing to do so may result in your program hanging
unpredictably.

Debug is not available in safe mode.



## Coverage

Coverage provides coverage measurement feature for Ruby. This feature is
experimental, so these APIs may be changed in future.

## Usage

1.  require "coverage"
2.  do Coverage.start
3.  require or load Ruby source file
4.  Coverage.result will return a hash that contains filename as key and
    coverage array as value. A coverage array gives, for each line, the
    number of line execution by the interpreter. A `nil` value means
    coverage is disabled for this line (lines like `else` and `end`).

## Example


```ruby
[foo.rb]
s = 0
10.times do |x|
  s += x
end

if s == 45
  p :ok
else
  p :ng
end
[EOF]

require "coverage"
Coverage.start
require "foo.rb"
p Coverage.result  #=> {"foo.rb"=>[1, 1, 10, nil, nil, 1, 1, nil, 0, nil]}
```



## PP

A pretty-printer for Ruby objects.

### What PP Does

Standard output by `#p` returns this: #<PP:0x81fedf0
@genspace=#<Proc:0x81feda0>,
@group\_queue=#<PrettyPrint::GroupQueue:0x81fed3c
@queue=\[\[#<PrettyPrint::Group:0x81fed78 @breakables=\[\], @depth=0,
@break=false>\], \[\]\]>, @buffer=\[\], @newline=\"\\n\",
@group\_stack=\[#<PrettyPrint::Group:0x81fed78 @breakables=\[\],
@depth=0, @break=false>\], @buffer\_width=0, @indent=0, @maxwidth=79,
@output\_width=2,
@output=#<IO:0x8114ee4>></IO:0x8114ee4></Proc:0x81feda0>

Pretty-printed output returns this: #<PP:0x81fedf0 @buffer=\[\],
@buffer\_width=0, @genspace=#<Proc:0x81feda0>, @group\_queue=
#<PrettyPrint::GroupQueue:0x81fed3c @queue=
\[\[#<PrettyPrint::Group:0x81fed78 @break=false, @breakables=\[\],
@depth=0>\], \[\]\]>, @group\_stack= \[#<PrettyPrint::Group:0x81fed78
@break=false, @breakables=\[\], @depth=0>\], @indent=0, @maxwidth=79,
@newline=\"\\n\", @output=#<IO:0x8114ee4>,
@output\_width=2></IO:0x8114ee4></Proc:0x81feda0>

### Usage


```ruby
pp(obj)             #=> obj
pp obj              #=> obj
pp(obj1, obj2, ...) #=> [obj1, obj2, ...]
pp()                #=> nil
```

Output `obj(s)` to `$>` in pretty printed format.

It returns `obj(s)`.

### Output Customization

To define a customized pretty printing function for your classes,
redefine method `#pretty_print(pp)` in the class.

`#pretty_print` takes the `pp` argument, which is an instance of the PP
class. The method uses `#text`, `#breakable`, `#nest`, `#group` and
`#pp` to print the object.

### Pretty-Print JSON

To pretty-print JSON refer to `JSON#pretty_generate`.

### Author

Tanaka Akira [akr@fsij.org](mailto:akr@fsij.org)



## PrettyPrint

This class implements a pretty printing algorithm. It finds line breaks
and nice indentations for grouped structure.

By default, the class assumes that primitive elements are strings and
each byte in the strings have single column in width. But it can be used
for other situations by giving suitable arguments for some methods:

* newline object and space generation block for PrettyPrint.new
* optional width argument for \`PrettyPrint#tex't
* \`PrettyPrint#breakabl'e

There are several candidate uses:

* text formatting using proportional fonts
* multibyte characters which has columns different to number of bytes
* non-string formatting

### Bugs

* Box based formatting?
* Other (better) model/algorithm?

Report any bugs at http://bugs.ruby-lang.org

### References

Christian Lindig, Strictly Pretty, March 2000,
http://www.st.cs.uni-sb.de/~lindig/papers/#pretty

Philip Wadler, A prettier printer, March 1998,
http://homepages.inf.ed.ac.uk/wadler/topics/language-design.html#prettier

### Author

Tanaka Akira [akr@fsij.org](mailto:akr@fsij.org)



## Profiler\_\_

Profile provides a way to Profile your Ruby application.

Profiling your program is a way of determining which methods are called
and how long each method takes to complete. This way you can detect
which methods are possible bottlenecks.

Profiling your program will slow down your execution time considerably,
so activate it only when you need it. Don't confuse benchmarking with
profiling.

There are two ways to activate Profiling:

### Command line

Run your Ruby script with `-rprofile`\:


```ruby
ruby -rprofile example.rb
```

If you're profiling an executable in your `$PATH` you can use `ruby
-S`\:


```ruby
ruby -rprofile -S some_executable
```

### From code

Just require 'profile'\:


```ruby
require 'profile'

def slow_method
  5000.times do
    9999999999999999*999999999
  end
end

def fast_method
  5000.times do
    9999999999999999+999999999
  end
end

slow_method
fast_method
```

The output in both cases is a report when the execution is over:


```ruby
ruby -rprofile example.rb

  %   cumulative   self              self     total
 time   seconds   seconds    calls  ms/call  ms/call  name
 68.42     0.13      0.13        2    65.00    95.00  Integer#times
 15.79     0.16      0.03     5000     0.01     0.01  Fixnum#*
 15.79     0.19      0.03     5000     0.01     0.01  Fixnum#+
  0.00     0.19      0.00        2     0.00     0.00  IO#set_encoding
  0.00     0.19      0.00        1     0.00   100.00  Object#slow_method
  0.00     0.19      0.00        2     0.00     0.00  Module#method_added
  0.00     0.19      0.00        1     0.00    90.00  Object#fast_method
  0.00     0.19      0.00        1     0.00   190.00  #toplevel
```



## Tracer

Outputs a source level execution trace of a Ruby program.

It does this by registering an event handler with
`Kernel#set_trace_func` for processing incoming events. It also provides
methods for filtering unwanted trace output (see Tracer.add\_filter,
Tracer.on, and Tracer.off).

### Example

Consider the following Ruby script


```ruby
class A
  def square(a)
    return a*a
  end
end

a = A.new
a.square(5)
```

Running the above script using `ruby -r tracer example.rb` will output
the following trace to STDOUT (Note you can also explicitly `require
`tracer'\`)


```ruby
#0:<internal:lib/rubygems/custom_require>:38:Kernel:<: -
#0:example.rb:3::-: class A
#0:example.rb:3::C: class A
#0:example.rb:4::-:   def square(a)
#0:example.rb:7::E: end
#0:example.rb:9::-: a = A.new
#0:example.rb:10::-: a.square(5)
#0:example.rb:4:A:>:   def square(a)
#0:example.rb:5:A:-:     return a*a
#0:example.rb:6:A:<:   end
 |  |         | |  |
 |  |         | |   ---------------------+ event
 |  |         |  ------------------------+ class
 |  |          --------------------------+ line
 |   ------------------------------------+ filename
  ---------------------------------------+ thread
```

Symbol table used for displaying incoming events:

* +}+: call a C-language routine

* +\{+: return from a C-language routine
* +>+: call a Ruby method
* `C`\: start a class or module definition
* `E`\: finish a class or module definition
* `-`\: execute code on a new line
* +^+: raise an exception
* +<+: return from a Ruby method

### Copyright

by Keiju ISHITSUKA(keiju@ishitsuka.com)



## Logger

### Description

The Logger class provides a simple but sophisticated logging utility
that you can use to output messages.

The messages have associated levels, such as `INFO` or `ERROR` that
indicate their importance. You can then give the Logger a level, and
only messages at that level or higher will be printed.

The levels are:

* `UNKNOWN`\: An unknown message that should always be logged.

* `FATAL`\: An unhandleable error that results in a program crash.
* `ERROR`\: A handleable error condition.
* `WARN`\: A warning.
* `INFO`\: Generic (useful) information about system operation.
* `DEBUG`\: Low-level information for developers.

For instance, in a production system, you may have your Logger set to
`INFO` or even `WARN`. When you are developing the system, however, you
probably want to know about the program's internal state, and would set
the Logger to `DEBUG`.

**Note**\: Logger does not escape or sanitize any messages passed to it.
Developers should be aware of when potentially malicious data
(user-input) is passed to Logger, and manually escape the untrusted
data:


```ruby
logger.info("User-input: #{input.dump}")
logger.info("User-input: %p" % input)
```

You can use `#formatter=` for escaping all data.


```ruby
original_formatter = Logger::Formatter.new
logger.formatter = proc { |severity, datetime, progname, msg|
  original_formatter.call(severity, datetime, progname, msg.dump)
}
logger.info(input)
```

#### Example

This creates a Logger that outputs to the standard output stream, with a
level of `WARN`\:


```ruby
require 'logger'

logger = Logger.new(STDOUT)
logger.level = Logger::WARN

logger.debug("Created logger")
logger.info("Program started")
logger.warn("Nothing to do!")

path = "a_non_existent_file"

begin
  File.foreach(path) do |line|
    unless line =~ /^(\w+) = (.*)$/
      logger.error("Line in wrong format: #{line.chomp}")
    end
  end
rescue => err
  logger.fatal("Caught exception; exiting")
  logger.fatal(err)
end
```

Because the Logger's level is set to `WARN`, only the warning, error,
and fatal messages are recorded. The debug and info messages are
silently discarded.

#### Features

There are several interesting features that Logger provides, like
auto-rolling of log files, setting the format of log messages, and
specifying a program name in conjunction with the message. The next
section shows you how to achieve these things.

### HOWTOs

#### How to create a logger

The options below give you various choices, in more or less increasing
complexity.

1.  Create a logger which logs messages to STDERR/STDOUT.
    
    
    ```ruby
    logger = Logger.new(STDERR)
    logger = Logger.new(STDOUT)
    ```

2.  Create a logger for the file which has the specified name.
    
    
    ```ruby
    logger = Logger.new('logfile.log')
    ```

3.  Create a logger for the specified file.
    
    
    ```ruby
    file = File.open('foo.log', File::WRONLY | File::APPEND)
    # To create new (and to remove old) logfile, add File::CREAT like:
    # file = File.open('foo.log', File::WRONLY | File::APPEND | File::CREAT)
    logger = Logger.new(file)
    ```

4.  Create a logger which ages the logfile once it reaches a certain
    size. Leave 10 "old" log files where each file is about 1,024,000
    bytes.
    
    
    ```ruby
    logger = Logger.new('foo.log', 10, 1024000)
    ```

5.  Create a logger which ages the logfile daily/weekly/monthly.
    
    
    ```ruby
    logger = Logger.new('foo.log', 'daily')
    logger = Logger.new('foo.log', 'weekly')
    logger = Logger.new('foo.log', 'monthly')
    ```

#### How to log a message

Notice the different methods (`fatal`, `error`, `info`) being used to
log messages of various levels? Other methods in this family are `warn`
and `debug`. `add` is used below to log a message of an arbitrary
(perhaps dynamic) level.

1.  Message in a block.
    
    
    ```ruby
    logger.fatal { "Argument 'foo' not given." }
    ```

2.  Message as a string.
    
    
    ```ruby
    logger.error "Argument #{@foo} mismatch."
    ```

3.  With progname.
    
    
    ```ruby
    logger.info('initialize') { "Initializing..." }
    ```

4.  With severity.
    
    
    ```ruby
    logger.add(Logger::FATAL) { 'Fatal error!' }
    ```

The block form allows you to create potentially complex log messages,
but to delay their evaluation until and unless the message is logged.
For example, if we have the following:


```ruby
logger.debug { "This is a " + potentially + " expensive operation" }
```

If the logger's level is `INFO` or higher, no debug messages will be
logged, and the entire block will not even be evaluated. Compare to
this:


```ruby
logger.debug("This is a " + potentially + " expensive operation")
```

Here, the string concatenation is done every time, even if the log level
is not set to show the debug message.

#### How to close a logger


```ruby
logger.close
```

#### Setting severity threshold

1.  Original interface.
    
    
    ```ruby
    logger.sev_threshold = Logger::WARN
    ```

2.  Log4r (somewhat) compatible interface.
    
    
    ```ruby
    logger.level = Logger::INFO
    
    # DEBUG < INFO < WARN < ERROR < FATAL < UNKNOWN
    ```

3.  Symbol or String (case insensitive)
    
    
    ```ruby
    logger.level = :info
    logger.level = 'INFO'
    
    # :debug < :info < :warn < :error < :fatal < :unknown
    ```

4.  Constructor
    
    
    ```ruby
    Logger.new(logdev, level: Logger::INFO)
    Logger.new(logdev, level: :info)
    Logger.new(logdev, level: 'INFO')
    ```

### Format

Log messages are rendered in the output stream in a certain format by
default. The default format and a sample are shown below:

Log format: SeverityID, \[DateTime #pid\] SeverityLabel -- ProgName:
message

Log sample: I, \[1999-03-03T02:34:24.895701 #19074\] INFO -- Main: info.

You may change the date and time format via `#datetime_format=`.


```ruby
logger.datetime_format = '%Y-%m-%d %H:%M:%S'
      # e.g. "2004-01-03 00:54:26"
```

or via the constructor.


```ruby
Logger.new(logdev, datetime_format: '%Y-%m-%d %H:%M:%S')
```

Or, you may change the overall format via the `#formatter=` method.


```ruby
logger.formatter = proc do |severity, datetime, progname, msg|
  "#{datetime}: #{msg}\n"
end
# e.g. "2005-09-22 08:51:08 +0900: hello world"
```

or via the constructor.


```ruby
Logger.new(logdev, formatter: proc {|severity, datetime, progname, msg|
  "#{datetime}: #{msg}\n"
})
```



## Ripper

Ripper is a Ruby script parser.

You can get information from the parser with event-based style.
Information such as abstract syntax trees or simple lexical analysis of
the Ruby program.

### Usage

Ripper provides an easy interface for parsing your program into a
symbolic expression tree (or S-expression).

Understanding the output of the parser may come as a challenge, it's
recommended you use PP to format the output for legibility.


```ruby
require 'ripper'
require 'pp'

pp Ripper.sexp('def hello(world) "Hello, #{world}!"; end')
  #=> [:program,
       [[:def,
         [:@ident, "hello", [1, 4]],
         [:paren,
          [:params, [[:@ident, "world", [1, 10]]], nil, nil, nil, nil, nil, nil]],
         [:bodystmt,
          [[:string_literal,
            [:string_content,
             [:@tstring_content, "Hello, ", [1, 18]],
             [:string_embexpr, [[:var_ref, [:@ident, "world", [1, 27]]]]],
             [:@tstring_content, "!", [1, 33]]]]],
          nil,
          nil,
          nil]]]]
```

You can see in the example above, the expression starts with `:program`.

From here, a method definition at `:def`, followed by the method's
identifier `:@ident`. After the method's identifier comes the
parentheses `:paren` and the method parameters under `:params`.

Next is the method body, starting at `:bodystmt` (`stmt` meaning
statement), which contains the full definition of the method.

In our case, we're simply returning a String, so next we have the
`:string_literal` expression.

Within our `:string_literal` you'll notice two `@tstring_content`, this
is the literal part for `Hello, ` and `!`. Between the two
`@tstring_content` statements is a `:string_embexpr`, where *embexpr* is
an embedded expression. Our expression consists of a local variable, or
`var_ref`, with the identifier (`@ident`) of `world`.

### Resources

* [Ruby Inside][1]

### Requirements

* ruby 1.9 (support CVS HEAD only)

* bison 1.28 or later (Other yaccs do not work)

### License

Ruby License.

* Minero Aoki

* aamine@loveruby.net
* http://i.loveruby.net



[1]: http://www.rubyinside.com/using-ripper-to-see-how-ruby-is-parsing-
your-code-5270.html


## Racc

Racc is a LALR(1) parser generator. It is written in Ruby itself, and
generates Ruby programs.

### Command-line Reference


```ruby
racc [-o<var>filename</var>] [--output-file=<var>filename</var>]
     [-e<var>rubypath</var>] [--embedded=<var>rubypath</var>]
     [-v] [--verbose]
     [-O<var>filename</var>] [--log-file=<var>filename</var>]
     [-g] [--debug]
     [-E] [--embedded]
     [-l] [--no-line-convert]
     [-c] [--line-convert-all]
     [-a] [--no-omit-actions]
     [-C] [--check-only]
     [-S] [--output-status]
     [--version] [--copyright] [--help] <var>grammarfile</var>
```

* `filename`\: Racc grammar file. Any extension is permitted.

* -o+outfile+, --output-file=`outfile`\: A filename for output. default
  is <`filename`>.tab.rb
* -O+filename+, --log-file=`filename`\: Place logging output in file
  `filename`. Default log file name is <`filename`>.output.

* -e+rubypath+, --executable=`rubypath`\: output executable file(mode
  755). where `path` is the Ruby interpreter.
* -v, --verbose: verbose mode. create `filename`.output file, like
  yacc's y.output file.
* -g, --debug: add debug code to parser class. To display debugging
  information, use this '-g' option and set @yydebug true in parser
  class.

* -E, --embedded: Output parser which doesn't need runtime files
  (racc/parser.rb).
* -C, --check-only: Check syntax of racc grammar file and quit.
* -S, --output-status: Print messages time to time while compiling.
* -l, --no-line-convert: turns off line number converting.
* -c, --line-convert-all: Convert line number of actions, inner, header
  and footer.
* -a, --no-omit-actions: Call all actions, even if an action is empty.
* --version: print Racc version and quit.
* --copyright: Print copyright and quit.
* --help: Print usage and quit.

### Generating Parser Using Racc

To compile Racc grammar file, simply type:


```ruby
$ racc parse.y
```

This creates Ruby script file "parse.tab.y". The -o option can change
the output filename.

### Writing A Racc Grammar File

If you want your own parser, you have to write a grammar file. A grammar
file contains the name of your parser class, grammar for the parser,
user code, and anything else. When writing a grammar file, yacc's
knowledge is helpful. If you have not used yacc before, Racc is not too
difficult.

Here's an example Racc grammar file.


```ruby
class Calcparser
rule
  target: exp { print val[0] }

  exp: exp '+' exp
     | exp '*' exp
     | '(' exp ')'
     | NUMBER
end
```

Racc grammar files resemble yacc files. But (of course), this is Ruby
code. yacc's \$$ is the 'result', $0, $1... is an array called 'val',
and $-1, $-2... is an array called '\_values'.

See the [Grammar File Reference](rdoc-ref:lib/racc/rdoc/grammar.en.rdoc)
for more information on grammar files.

### Parser

Then you must prepare the parse entry method. There are two types of
parse methods in Racc, `Racc::Parser#do_parse` and
\`Racc::Parser#yypars'e

Racc::`Parser#do_parse` is simple.

It's yyparse() of yacc, and `Racc::Parser#next_token` is yylex(). This
method must returns an array like \[TOKENSYMBOL, ITS\_VALUE\]. EOF is
\[false, false\]. (TOKENSYMBOL is a Ruby symbol (taken from
`String#intern`) by default. If you want to change this, see the grammar
reference.

Racc::`Parser#yyparse` is little complicated, but useful. It does not
use Racc::`Parser#next_token`, instead it gets tokens from any iterator.

For example, `yyparse(obj, :scan)` causes calling +obj#scan+, and you
can return tokens by yielding them from +obj#scan+.

### Debugging

When debugging, "-v" or/and the "-g" option is helpful.

"-v" creates verbose log file (.output). "-g" creates a "Verbose
Parser". Verbose Parser prints the internal status when parsing. But
it's *not* automatic. You must use -g option and set +@yydebug+ to
`true` in order to get output. -g option only creates the verbose
parser.

#### Racc reported syntax error.

Isn't there too many "end"? grammar of racc file is changed in v0.10.

Racc does not use '%' mark, while yacc uses huge number of '%' marks..

#### Racc reported "XXXX conflicts".

Try "racc -v xxxx.y". It causes producing racc's internal log file,
xxxx.output.

#### Generated parsers does not work correctly

Try "racc -g xxxx.y". This command let racc generate "debugging parser".
Then set @yydebug=true in your parser. It produces a working log of your
parser.

### Re-distributing Racc runtime

A parser, which is created by Racc, requires the Racc runtime module;
racc/parser.rb.

Ruby 1.8.x comes with Racc runtime module, you need NOT distribute Racc
runtime files.

If you want to include the Racc runtime module with your parser. This
can be done by using '-E' option:


```ruby
$ racc -E -omyparser.rb myparser.y
```

This command creates myparser.rb which `includes` Racc runtime. Only you
must do is to distribute your parser file (myparser.rb).

Note: parser.rb is LGPL, but your parser is not. Your own parser is
completely yours.



## Fiddle

A libffi wrapper for Ruby.

### Description

Fiddle is an extension to translate a foreign function interface (FFI)
with ruby.

It wraps [libffi][1], a popular C library which provides a portable
interface that allows code written in one language to call code written
in another language.

### Example

Here we will use Fiddle::Function to wrap [floor(3) from libm][2]


```ruby
require 'fiddle'

libm = Fiddle.dlopen('/lib/libm.so.6')

floor = Fiddle::Function.new(
  libm['floor'],
  [Fiddle::TYPE_DOUBLE],
  Fiddle::TYPE_DOUBLE
)

puts floor.call(3.14159) #=> 3.0
```



[1]: http://sourceware.org/libffi/
[2]: http://linux.die.net/man/3/floor
