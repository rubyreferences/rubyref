---
title: Other Libraries
prev: "/stdlib/misc/timeout.html"
next: "/stdlib/bundled.html"
---

## A Brief List of Less Used Libraries[](#a-brief-list-of-less-used-libraries)



### Abbrev[](#abbrev)

Calculates the set of unambiguous abbreviations for a given set of
strings.


```ruby
require 'abbrev'
require 'pp'

pp Abbrev.abbrev(['ruby'])
#=>  {"ruby"=>"ruby", "rub"=>"ruby", "ru"=>"ruby", "r"=>"ruby"}

pp Abbrev.abbrev(%w{ ruby rules })
```

*Generates:*


```ruby
{ "ruby"  =>  "ruby",
  "rub"   =>  "ruby",
  "rules" =>  "rules",
  "rule"  =>  "rules",
  "rul"   =>  "rules" }
```

It also provides an array core extension, `Array#abbrev`.


```ruby
pp %w{ summer winter }.abbrev
```

*Generates:*


```ruby
{ "summer"  => "summer",
  "summe"   => "summer",
  "summ"    => "summer",
  "sum"     => "summer",
  "su"      => "summer",
  "s"       => "summer",
  "winter"  => "winter",
  "winte"   => "winter",
  "wint"    => "winter",
  "win"     => "winter",
  "wi"      => "winter",
  "w"       => "winter" }
```

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/abbrev/rdoc/Abbrev.html'
class='ruby-doc remote' target='_blank'>Abbrev Reference</a>



### CMath[](#cmath)

CMath is a library that provides trigonometric and transcendental
functions for complex numbers. The functions in this module accept
integers, floating-point numbers or complex numbers as arguments.

Note that the selection of functions is similar, but not identical, to
that in module math. The reason for having two modules is that some
users aren't interested in complex numbers, and perhaps don't even know
what they are. They would rather have Math.sqrt(-1) raise an exception
than return a complex number.

For more information you can see Complex class.

<a href='https://ruby-doc.org/stdlib-2.5.0/libdoc/cmath/rdoc/CMath.html'
class='ruby-doc remote' target='_blank'>CMath Reference</a>



### GetoptLong[](#getoptlong)

The GetoptLong class allows you to parse command line options similarly
to the GNU getopt\_long() C library call. Note, however, that GetoptLong
is a pure Ruby implementation.

GetoptLong allows for POSIX-style options like `--file` as well as
single letter options like `-f`

The empty option `--` (two minus symbols) is used to end option
processing. This can be particularly important if options have optional
arguments.

Here is a simple example of usage:


```ruby
require 'getoptlong'

opts = GetoptLong.new(
  [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
  [ '--repeat', '-n', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--name', GetoptLong::OPTIONAL_ARGUMENT ]
)

dir = nil
name = nil
repetitions = 1
opts.each do |opt, arg|
  case opt
    when '--help'
      puts <<-EOF
hello [OPTION] ... DIR

-h, --help:
   show help

--repeat x, -n x:
   repeat x times

--name [name]:
   greet user by name, if name not supplied default is John

DIR: The directory in which to issue the greeting.
      EOF
    when '--repeat'
      repetitions = arg.to_i
    when '--name'
      if arg == ''
        name = 'John'
      else
        name = arg
      end
  end
end

if ARGV.length != 1
  puts "Missing dir argument (try --help)"
  exit 0
end

dir = ARGV.shift

Dir.chdir(dir)
for i in (1..repetitions)
  print "Hello"
  if name
    print ", #{name}"
  end
  puts
end
```

Example command line:


```
hello -n 6 --name -- /tmp
```

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/getoptlong/rdoc/GetoptLong.html'
class='ruby-doc remote' target='_blank'>GetoptLong Reference</a>



### Exception2MessageMapper[](#exception2messagemapper)

Helper module for easily defining exceptions with predefined messages.

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/e2mmap/rdoc/Exception2MessageMapper.html'
class='ruby-doc remote' target='_blank'>Exception2MessageMapper
Reference</a>



### NKF[](#nkf)

NKF - Ruby extension for Network Kanji Filter

<a href='https://ruby-doc.org/stdlib-2.5.0/libdoc/nkf/rdoc/NKF.html'
class='ruby-doc remote' target='_blank'>NKF Reference</a>



### PStore[](#pstore)

PStore implements a file based persistence mechanism based on a Hash.
User code can store hierarchies of Ruby objects (values) into the data
store file by name (keys). An object hierarchy may be just a single
object. User code may later read values back from the data store or even
update data, as needed.

The transactional behavior ensures that any changes succeed or fail
together. This can be used to ensure that the data store is not left in
a transitory state, where some values were updated but others were not.

Behind the scenes, Ruby objects are stored to the data store file with
Marshal. That carries the usual limitations. Proc objects cannot be
marshalled, for example.

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/pstore/rdoc/PStore.html'
class='ruby-doc remote' target='_blank'>PStore Reference</a>



### Rinda[](#rinda)

A module to implement the Linda distributed computing paradigm in Ruby.

Rinda is part of DRb (dRuby).

<a href='https://ruby-doc.org/stdlib-2.5.0/libdoc/rinda/rdoc/Rinda.html'
class='ruby-doc remote' target='_blank'>Rinda Reference</a>



### ThreadsWait[](#threadswait)

This class watches for termination of multiple threads. Basic
functionality (wait until specified threads have terminated) can be
accessed through the class method ThreadsWait::all\_waits. Finer control
can be gained using instance methods.

Example:


```
ThreadsWait.all_waits(thr1, thr2, ...) do |t|
  STDERR.puts "Thread #{t} has terminated."
end

th = ThreadsWait.new(thread1,...)
th.next_wait # next one to be done
```

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/thwait/rdoc/ThreadsWait.html'
class='ruby-doc remote' target='_blank'>ThreadsWait Reference</a>



### TSort[](#tsort)

TSort implements topological sorting using Tarjan's algorithm for
strongly connected components.

TSort is designed to be able to be used with any object which can be
interpreted as a directed graph.

TSort requires two methods to interpret an object as a graph,
tsort\_each\_node and tsort\_each\_child.

* tsort\_each\_node is used to iterate for all nodes over a graph.
* tsort\_each\_child is used to iterate for child nodes of a given node.

The equality of nodes are defined by eql? and hash since TSort uses Hash
internally.

<a href='https://ruby-doc.org/stdlib-2.5.0/libdoc/tsort/rdoc/TSort.html'
class='ruby-doc remote' target='_blank'>TSort Reference</a>



### WeakRef[](#weakref)

Weak Reference class that allows a referenced object to be
garbage-collected.

A WeakRef may be used exactly like the object it references.

Usage:


```ruby
foo = Object.new            # create a new object instance
p foo.to_s                  # original's class
foo = WeakRef.new(foo)      # reassign foo with WeakRef instance
p foo.to_s                  # should be same class
GC.start                    # start the garbage collector
p foo.to_s                  # should raise exception (recycled)
```

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/weakref/rdoc/WeakRef.html'
class='ruby-doc remote' target='_blank'>WeakRef Reference</a>

