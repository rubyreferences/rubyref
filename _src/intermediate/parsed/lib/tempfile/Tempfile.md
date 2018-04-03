# Tempfile

A utility class for managing temporary files. When you create a Tempfile
object, it will create a temporary file with a unique filename. A Tempfile
objects behaves just like a File object, and you can perform all the usual
file operations on it: reading data, writing data, changing its permissions,
etc. So although this class does not explicitly document all instance methods
supported by File, you can in fact call any File instance method on a Tempfile
object.

## Synopsis

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

## Good practices

### Explicit close

When a Tempfile object is garbage collected, or when the Ruby interpreter
exits, its associated temporary file is automatically deleted. This means
that's it's unnecessary to explicitly delete a Tempfile after use, though it's
good practice to do so: not explicitly deleting unused Tempfiles can
potentially leave behind large amounts of tempfiles on the filesystem until
they're garbage collected. The existence of these temp files can make it
harder to determine a new Tempfile filename.

Therefore, one should always call #unlink or close in an ensure block, like
this:

    file = Tempfile.new('foo')
    begin
       ...do something with file...
    ensure
       file.close
       file.unlink   # deletes the temp file
    end

### Unlink after creation

On POSIX systems, it's possible to unlink a file right after creating it, and
before closing it. This removes the filesystem entry without closing the file
handle, so it ensures that only the processes that already had the file handle
open can access the file's contents. It's strongly recommended that you do
this if you do not want any other processes to be able to read from or write
to the Tempfile, and you do not need to know the Tempfile's filename either.

For example, a practical use case for unlink-after-creation would be this: you
need a large byte buffer that's too large to comfortably fit in RAM, e.g. when
you're writing a web server and you want to buffer the client's file upload
data.

Please refer to #unlink for more information and a code example.

## Minor notes

Tempfile's filename picking method is both thread-safe and inter-process-safe:
it guarantees that no other threads or processes will pick the same filename.

Tempfile itself however may not be entirely thread-safe. If you access the
same Tempfile object from multiple threads then you should protect it with a
mutex.

[Tempfile Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/tempfile/rdoc/Tempfile.html)
