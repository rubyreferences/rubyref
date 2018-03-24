# IO

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

## io/console

The io/console extension provides methods for interacting with the
console. The console can be accessed from IO.console or the standard
input/output/error IO objects.

Requiring io/console adds the following methods:

* IO::console
* `IO#raw`
* `IO#raw!`
* `IO#cooked`
* `IO#cooked!`
* `IO#getch`
* `IO#echo=`
* `IO#echo?`
* `IO#noecho`
* `IO#winsize`
* `IO#winsize=`
* `IO#iflush`
* `IO#ioflush`
* `IO#oflush`

Example:


```ruby
require 'io/console'
rows, columns = $stdout.winsize
puts "Your screen is #{columns} wide and #{rows} tall"
```

[IO Reference](http://ruby-doc.org/core-2.5.0/IO.html)



## StringIO

Pseudo I/O on String object.

Commonly used to simulate `$stdio` or `$stderr`

#### Examples


```ruby
require 'stringio'

io = StringIO.new
io.puts "Hello World"
io.string #=> "Hello World\n"
```

[StringIO
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/stringio/rdoc/StringIO.html)



## Dir

Objects of class `Dir` are directory streams representing directories in
the underlying file system. They provide a variety of ways to list
directories and their contents. See also `File`.

The directory used in these examples contains the two regular files
(`config.h` and `main.rb`), the parent directory (`..`), and the
directory itself (`.`).

[Dir Reference](http://ruby-doc.org/core-2.5.0/Dir.html)



## FileTest

`FileTest` implements file test operations similar to those used in
`File::Stat`. It exists as a standalone module, and its methods are also
insinuated into the `File` class. (Note that this is not done by
inclusion: the interpreter cheats).

[FileTest Reference](http://ruby-doc.org/core-2.5.0/FileTest.html)



## File

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

[File Reference](http://ruby-doc.org/core-2.5.0/File.html)



## Pathname

Pathname represents the name of a file or directory on the filesystem,
but not the file itself.

The pathname depends on the Operating System: Unix, Windows, etc. This
library works with pathnames of local OS, however non-Unix pathnames are
supported experimentally.

A Pathname can be relative or absolute. It's not until you try to
reference the file that it even matters whether the file exists or not.

Pathname is immutable. It has no method for destructive update.

The goal of this class is to manipulate file path information in a
neater way than standard Ruby provides. The examples below demonstrate
the difference.

**All** functionality from File, FileTest, and some from Dir and
FileUtils is included, in an unsurprising way. It is essentially a
facade for all of these, and more.

### Examples

#### Example 1: Using Pathname


```ruby
require 'pathname'
pn = Pathname.new("/usr/bin/ruby")
size = pn.size              # 27662
isdir = pn.directory?       # false
dir  = pn.dirname           # Pathname:/usr/bin
base = pn.basename          # Pathname:ruby
dir, base = pn.split        # [Pathname:/usr/bin, Pathname:ruby]
data = pn.read
pn.open { |f| _ }
pn.each_line { |line| _ }
```

#### Example 2: Using standard Ruby


```ruby
pn = "/usr/bin/ruby"
size = File.size(pn)        # 27662
isdir = File.directory?(pn) # false
dir  = File.dirname(pn)     # "/usr/bin"
base = File.basename(pn)    # "ruby"
dir, base = File.split(pn)  # ["/usr/bin", "ruby"]
data = File.read(pn)
File.open(pn) { |f| _ }
File.foreach(pn) { |line| _ }
```

#### Example 3: Special features


```ruby
p1 = Pathname.new("/usr/lib")   # Pathname:/usr/lib
p2 = p1 + "ruby/1.8"            # Pathname:/usr/lib/ruby/1.8
p3 = p1.parent                  # Pathname:/usr
p4 = p2.relative_path_from(p3)  # Pathname:lib/ruby/1.8
pwd = Pathname.pwd              # Pathname:/home/gavin
pwd.absolute?                   # true
p5 = Pathname.new "."           # Pathname:.
p5 = p5 + "music/../articles"   # Pathname:music/../articles
p5.cleanpath                    # Pathname:articles
p5.realpath                     # Pathname:/home/gavin/articles
p5.children                     # [Pathname:/home/gavin/articles/linux, ...]
```

### Breakdown of functionality

#### Core methods

These methods are effectively manipulating a String, because that's all
a path is. None of these access the file system except for
`#mountpoint?`, `#children`, `#each_child`, `#realdirpath` and
`#realpath`.

* +
* `#join`
* `#parent`
* `#root?`
* `#absolute?`
* `#relative?`
* `#relative_path_from`
* `#each_filename`
* `#cleanpath`
* `#realpath`
* `#realdirpath`
* `#children`
* `#each_child`
* `#mountpoint?`

#### File status predicate methods

These methods are a facade for FileTest:

* `#blockdev?`
* `#chardev?`
* `#directory?`
* `#executable?`
* `#executable_real?`
* `#exist?`
* `#file?`
* `#grpowned?`
* `#owned?`
* `#pipe?`
* `#readable?`
* `#world_readable?`
* `#readable_real?`
* `#setgid?`
* `#setuid?`
* `#size`
* `#size?`
* `#socket?`
* `#sticky?`
* `#symlink?`
* `#writable?`
* `#world_writable?`
* `#writable_real?`
* `#zero?`

#### File property and manipulation methods

These methods are a facade for File:

* `#atime`
* `#birthtime`
* `#ctime`
* `#mtime`
* `#chmod`(mode)
* `#lchmod`(mode)
* `#chown`(owner, group)
* `#lchown`(owner, group)
* `#fnmatch`(pattern, \*args)
* `#fnmatch?`(pattern, \*args)
* `#ftype`
* `#make_link`(old)
* `#open`(\*args, &block)
* `#readlink`
* `#rename`(to)
* `#stat`
* `#lstat`
* `#make_symlink`(old)
* `#truncate`(length)
* `#utime`(atime, mtime)
* `#basename`(\*args)
* `#dirname`
* `#extname`
* `#expand_path`(\*args)
* `#split`

#### Directory methods

These methods are a facade for Dir:

* Pathname.glob(\*args)
* Pathname.getwd / Pathname.pwd
* `#rmdir`
* `#entries`
* `#each_entry`(&block)
* `#mkdir`(\*args)
* `#opendir`(\*args)

#### IO

These methods are a facade for IO:

* `#each_line`(\*args, &block)
* `#read`(\*args)
* `#binread`(\*args)
* `#readlines`(\*args)
* `#sysopen`(\*args)

#### Utilities

These methods are a mixture of Find, FileUtils, and others:

* `#find`(&block)
* `#mkpath`
* `#rmtree`
* `#unlink` / `#delete`

### Method documentation

As the above section shows, most of the methods in Pathname are facades.
The documentation for these methods generally just says, for instance,
"See FileTest.writable?", as you should be familiar with the original
method anyway, and its documentation (e.g. through `ri`) will contain
more information. In some cases, a brief description will follow.

[Pathname
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/pathname/rdoc/Pathname.html)



## Tempfile

A utility class for managing temporary files. When you create a Tempfile
object, it will create a temporary file with a unique filename. A
Tempfile objects behaves just like a File object, and you can perform
all the usual file operations on it: reading data, writing data,
changing its permissions, etc. So although this class does not
explicitly document all instance methods supported by File, you can in
fact call any File instance method on a Tempfile object.

### Synopsis


```ruby
require 'tempfile'

file = Tempfile.new('foo')
file.path      # => A unique filename in the OS's temp directory,
               #    e.g.: "/tmp/foo.24722.0"
               #    This filename contains 'foo' in its basename.
file.write("hello world")
file.rewind
file.read      # => "hello world"
file.close
file.unlink    # deletes the temp file
```

### Good practices

#### Explicit close

When a Tempfile object is garbage collected, or when the Ruby
interpreter exits, its associated temporary file is automatically
deleted. This means that's it's unnecessary to explicitly delete a
Tempfile after use, though it's good practice to do so: not explicitly
deleting unused Tempfiles can potentially leave behind large amounts of
tempfiles on the filesystem until they're garbage collected. The
existence of these temp files can make it harder to determine a new
Tempfile filename.

Therefore, one should always call `#unlink` or close in an ensure block,
like this:


```ruby
file = Tempfile.new('foo')
begin
   ...do something with file...
ensure
   file.close
   file.unlink   # deletes the temp file
end
```

#### Unlink after creation

On POSIX systems, it's possible to unlink a file right after creating
it, and before closing it. This removes the filesystem entry without
closing the file handle, so it ensures that only the processes that
already had the file handle open can access the file's contents. It's
strongly recommended that you do this if you do not want any other
processes to be able to read from or write to the Tempfile, and you do
not need to know the Tempfile's filename either.

For example, a practical use case for unlink-after-creation would be
this: you need a large byte buffer that's too large to comfortably fit
in RAM, e.g. when you're writing a web server and you want to buffer the
client's file upload data.

Please refer to `#unlink` for more information and a code example.

### Minor notes

Tempfile's filename picking method is both thread-safe and
inter-process-safe: it guarantees that no other threads or processes
will pick the same filename.

Tempfile itself however may not be entirely thread-safe. If you access
the same Tempfile object from multiple threads then you should protect
it with a mutex.

[Tempfile
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/tempfile/rdoc/Tempfile.html)



## FileUtils

## fileutils.rb

Copyright (c) 2000-2007 Minero Aoki

This program is free software. You can distribute/modify this program
under the same terms of ruby.

### module FileUtils

Namespace for several file utility methods for copying, moving,
removing, etc.

#### Module Functions


```ruby
require 'fileutils'

FileUtils.cd(dir, options)
FileUtils.cd(dir, options) {|dir| block }
FileUtils.pwd()
FileUtils.mkdir(dir, options)
FileUtils.mkdir(list, options)
FileUtils.mkdir_p(dir, options)
FileUtils.mkdir_p(list, options)
FileUtils.rmdir(dir, options)
FileUtils.rmdir(list, options)
FileUtils.ln(target, link, options)
FileUtils.ln(targets, dir, options)
FileUtils.ln_s(target, link, options)
FileUtils.ln_s(targets, dir, options)
FileUtils.ln_sf(target, link, options)
FileUtils.cp(src, dest, options)
FileUtils.cp(list, dir, options)
FileUtils.cp_r(src, dest, options)
FileUtils.cp_r(list, dir, options)
FileUtils.mv(src, dest, options)
FileUtils.mv(list, dir, options)
FileUtils.rm(list, options)
FileUtils.rm_r(list, options)
FileUtils.rm_rf(list, options)
FileUtils.install(src, dest, options)
FileUtils.chmod(mode, list, options)
FileUtils.chmod_R(mode, list, options)
FileUtils.chown(user, group, list, options)
FileUtils.chown_R(user, group, list, options)
FileUtils.touch(list, options)
```

The `options` parameter is a hash of options, taken from the list
`:force`, `:noop`, `:preserve`, and `:verbose`. `:noop` means that no
changes are made. The other three are obvious. Each method documents the
options that it honours.

All methods that have the concept of a "source" file or directory can
take either one file or a list of files in that argument. See the method
documentation for examples.

There are some `low level` methods, which do not accept any option:


```ruby
FileUtils.copy_entry(src, dest, preserve = false, dereference = false)
FileUtils.copy_file(src, dest, preserve = false, dereference = true)
FileUtils.copy_stream(srcstream, deststream)
FileUtils.remove_entry(path, force = false)
FileUtils.remove_entry_secure(path, force = false)
FileUtils.remove_file(path, force = false)
FileUtils.compare_file(path_a, path_b)
FileUtils.compare_stream(stream_a, stream_b)
FileUtils.uptodate?(file, cmp_list)
```

### module FileUtils::Verbose

This module has all methods of FileUtils module, but it outputs messages
before acting. This equates to passing the `:verbose` flag to methods in
FileUtils.

### module FileUtils::NoWrite

This module has all methods of FileUtils module, but never changes
files/directories. This equates to passing the `:noop` flag to methods
in FileUtils.

### module FileUtils::DryRun

This module has all methods of FileUtils module, but never changes
files/directories. This equates to passing the `:noop` and `:verbose`
flags to methods in FileUtils.

[FileUtils
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/fileutils/rdoc/FileUtils.html)

