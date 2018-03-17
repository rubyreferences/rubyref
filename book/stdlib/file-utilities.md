# Pathname

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

## Examples

### Example 1: Using Pathname


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

### Example 2: Using standard Ruby


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

### Example 3: Special features


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

## Breakdown of functionality

### Core methods

These methods are effectively manipulating a String, because that's all
a path is. None of these access the file system except for
`#mountpoint?`, `#children`, `#each_child`, `#realdirpath` and
`#realpath`.

* +

* # join

* # parent

* # root?

* # absolute?

* # relative?

* # relative\_path\_from

* # each\_filename

* # cleanpath

* # realpath

* # realdirpath

* # children

* # each\_child

* # mountpoint?

### File status predicate methods

These methods are a facade for FileTest:

* # blockdev?

* # chardev?

* # directory?

* # executable?

* # executable\_real?

* # exist?

* # file?

* # grpowned?

* # owned?

* # pipe?

* # readable?

* # world\_readable?

* # readable\_real?

* # setgid?

* # setuid?

* # size

* # size?

* # socket?

* # sticky?

* # symlink?

* # writable?

* # world\_writable?

* # writable\_real?

* # zero?

### File property and manipulation methods

These methods are a facade for File:

* # atime

* # birthtime

* # ctime

* # mtime

* `#chmod`(mode)
* `#lchmod`(mode)
* `#chown`(owner, group)
* `#lchown`(owner, group)
* `#fnmatch`(pattern, \*args)
* `#fnmatch?`(pattern, \*args)
* # ftype

* `#make_link`(old)
* `#open`(\*args, &block)
* # readlink

* `#rename`(to)
* # stat

* # lstat

* `#make_symlink`(old)
* `#truncate`(length)
* `#utime`(atime, mtime)
* `#basename`(\*args)
* # dirname

* # extname

* `#expand_path`(\*args)
* # split

### Directory methods

These methods are a facade for Dir:

* Pathname.glob(\*args)
* Pathname.getwd / Pathname.pwd
* # rmdir

* # entries

* `#each_entry`(&block)
* `#mkdir`(\*args)
* `#opendir`(\*args)

### IO

These methods are a facade for IO:

* `#each_line`(\*args, &block)
* `#read`(\*args)
* `#binread`(\*args)
* `#readlines`(\*args)
* `#sysopen`(\*args)

### Utilities

These methods are a mixture of Find, FileUtils, and others:

* `#find`(&block)
* # mkpath

* # rmtree

* `#unlink` / #delete

## Method documentation

As the above section shows, most of the methods in Pathname are facades.
The documentation for these methods generally just says, for instance,
"See FileTest.writable?", as you should be familiar with the original
method anyway, and its documentation (e.g. through `ri`) will contain
more information. In some cases, a brief description will follow.



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



## Find

The `Find` module supports the top-down traversal of a set of file
paths.

For example, to total the size of all files under your home directory,
ignoring anything in a "dot" directory (e.g. $HOME/.ssh):


```ruby
require 'find'

total_size = 0

Find.find(ENV["HOME"]) do |path|
  if FileTest.directory?(path)
    if File.basename(path)[0] == ?.
      Find.prune       # Don't look any further into this directory.
    else
      next
    end
  else
    total_size += FileTest.size(path)
  end
end
```

