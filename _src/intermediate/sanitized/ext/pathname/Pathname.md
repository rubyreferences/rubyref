# Pathname

Pathname represents the name of a file or directory on the filesystem, but not
the file itself.

The pathname depends on the Operating System: Unix, Windows, etc. This library
works with pathnames of local OS, however non-Unix pathnames are supported
experimentally.

A Pathname can be relative or absolute.  It's not until you try to reference
the file that it even matters whether the file exists or not.

Pathname is immutable.  It has no method for destructive update.

The goal of this class is to manipulate file path information in a neater way
than standard Ruby provides.  The examples below demonstrate the difference.

**All** functionality from File, FileTest, and some from Dir and FileUtils is
included, in an unsurprising way.  It is essentially a facade for all of
these, and more.

## Examples

### Example 1: Using Pathname

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

### Example 2: Using standard Ruby

    pn = "/usr/bin/ruby"
    size = File.size(pn)        # 27662
    isdir = File.directory?(pn) # false
    dir  = File.dirname(pn)     # "/usr/bin"
    base = File.basename(pn)    # "ruby"
    dir, base = File.split(pn)  # ["/usr/bin", "ruby"]
    data = File.read(pn)
    File.open(pn) { |f| _ }
    File.foreach(pn) { |line| _ }

### Example 3: Special features

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

## Breakdown of functionality

### Core methods

These methods are effectively manipulating a String, because that's all a path
is.  None of these access the file system except for `#mountpoint?`, `#children`,
`#each_child`, `#realdirpath` and `#realpath`.

*   +
*   `#join`
*   `#parent`
*   `#root?`
*   `#absolute?`
*   `#relative?`
*   `#relative_path_from`
*   `#each_filename`
*   `#cleanpath`
*   `#realpath`
*   `#realdirpath`
*   `#children`
*   `#each_child`
*   `#mountpoint?`


### File status predicate methods

These methods are a facade for FileTest:

*   `#blockdev?`
*   `#chardev?`
*   `#directory?`
*   `#executable?`
*   `#executable_real?`
*   `#exist?`
*   `#file?`
*   `#grpowned?`
*   `#owned?`
*   `#pipe?`
*   `#readable?`
*   `#world_readable?`
*   `#readable_real?`
*   `#setgid?`
*   `#setuid?`
*   `#size`
*   `#size?`
*   `#socket?`
*   `#sticky?`
*   `#symlink?`
*   `#writable?`
*   `#world_writable?`
*   `#writable_real?`
*   `#zero?`


### File property and manipulation methods

These methods are a facade for File:

*   `#atime`
*   `#birthtime`
*   `#ctime`
*   `#mtime`
*   `#chmod`(mode)
*   `#lchmod`(mode)
*   `#chown`(owner, group)
*   `#lchown`(owner, group)
*   `#fnmatch`(pattern, *args)
*   `#fnmatch?`(pattern, *args)
*   `#ftype`
*   `#make_link`(old)
*   `#open`(*args, &block)
*   `#readlink`
*   `#rename`(to)
*   `#stat`
*   `#lstat`
*   `#make_symlink`(old)
*   `#truncate`(length)
*   `#utime`(atime, mtime)
*   `#basename`(*args)
*   `#dirname`
*   `#extname`
*   `#expand_path`(*args)
*   `#split`


### Directory methods

These methods are a facade for Dir:

*   Pathname.glob(*args)
*   Pathname.getwd / Pathname.pwd
*   `#rmdir`
*   `#entries`
*   `#each_entry`(&block)
*   `#mkdir`(*args)
*   `#opendir`(*args)


### IO

These methods are a facade for IO:

*   `#each_line`(*args, &block)
*   `#read`(*args)
*   `#binread`(*args)
*   `#readlines`(*args)
*   `#sysopen`(*args)


### Utilities

These methods are a mixture of Find, FileUtils, and others:

*   `#find`(&block)
*   `#mkpath`
*   `#rmtree`
*   `#unlink` / `#delete`


## Method documentation

As the above section shows, most of the methods in Pathname are facades.  The
documentation for these methods generally just says, for instance, "See
FileTest.writable?", as you should be familiar with the original method
anyway, and its documentation (e.g. through `ri`) will contain more
information.  In some cases, a brief description will follow.

[Pathname Reference](https://ruby-doc.org/stdlib-2.6/libdoc/pathname/rdoc/Pathname.html)