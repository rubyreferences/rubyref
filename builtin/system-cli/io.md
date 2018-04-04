---
title: IO Basics
prev: "/builtin/system-cli/processes-signals.html"
next: "/builtin/system-cli/filesystem.html"
---

## IO

The IO class is the basis for all input and output in Ruby. An I/O
stream may be *duplexed* (that is, bidirectional), and so may use more
than one native operating system stream.

Many of the examples in this section use the File class, the only
standard subclass of IO. The two classes are closely associated. Like
the File class, the Socket library subclasses from IO (such as TCPSocket
or UDPSocket).

The `Kernel#open` method can create an IO (or File) object for these
types of arguments:

* A plain string represents a filename suitable for the underlying
  operating system.

* A string starting with `"|"` indicates a subprocess. The remainder of
  the string following the `"|"` is invoked as a process with
  appropriate input/output channels connected to it.

* A string equal to `"|-"` will create another Ruby instance as a
  subprocess.

The IO may be opened with different file modes (read-only, write-only)
and encodings for proper conversion. See IO.new for these options. See
Kernel#open for details of the various command formats described above.

IO.popen, the Open3 library, or `Process#spawn` may also be used to
communicate with subprocesses through an IO.

Ruby will convert pathnames between different operating system
conventions if possible. For instance, on a Windows system the filename
`"/gumby/ruby/test.rb"` will be opened as `"\gumby\ruby\test.rb"`. When
specifying a Windows-style filename in a Ruby string, remember to escape
the backslashes:


```ruby
"C:\\gumby\\ruby\\test.rb"
```

Our examples here will use the Unix-style forward slashes;
File::ALT\_SEPARATOR can be used to get the platform-specific separator
character.

The global constant ARGF (also accessible as `$<`) provides an IO-like
stream which allows access to all files mentioned on the command line
(or STDIN if no files are mentioned). `ARGF#path` and its alias
`ARGF#filename` are provided to access the name of the file currently
being read.

<a href='https://ruby-doc.org/core-2.5.0/IO.html' class='ruby-doc
remote' target='_blank'>IO Reference</a>



### File

A `File` is an abstraction of any file object accessible by the program
and is closely associated with class `IO`. `File` includes the methods
of module `FileTest` as class methods, allowing you to write (for
example) `File.exist?("foo")`.

In the description of File methods, *permission bits* are a
platform-specific set of bits that indicate permissions of a file. On
Unix-based systems, permissions are viewed as a set of three octets, for
the owner, the group, and the rest of the world. For each of these
entities, permissions may be set to read, write, or execute the file:

The permission bits `0644` (in octal) would thus be interpreted as
read/write for owner, and read-only for group and other. Higher-order
bits may also be used to indicate the type of file (plain, directory,
pipe, socket, and so on) and various other special features. If the
permissions are for a directory, the meaning of the execute bit changes;
when set the directory can be searched.

On non-Posix operating systems, there may be only the ability to make a
file read-only or read-write. In this case, the remaining permission
bits will be synthesized to resemble typical values. For instance, on
Windows NT the default permission bits are `0644`, which means
read/write for owner, read-only for all others. The only change that can
be made is to make the file read-only, which is reported as `0444`.

Various constants for the methods in File can be found in
File::Constants.

<a href='https://ruby-doc.org/core-2.5.0/File.html' class='ruby-doc
remote' target='_blank'>File Reference</a>



### StringIO

*Part of standard library. You need to `require 'stringio'` before
using.*

Pseudo I/O on String object.

Commonly used to simulate `$stdio` or `$stderr`

##### Examples


```ruby
require 'stringio'

io = StringIO.new
io.puts "Hello World"
io.string #=> "Hello World\n"
```

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/stringio/rdoc/StringIO.html'
class='ruby-doc remote' target='_blank'>StringIO Reference</a>

