# IOError

Raised when an IO operation fails.

    File.open("/etc/hosts") {|f| f << "example"}
      #=> IOError: not opened for writing

    File.open("/etc/hosts") {|f| f.close; f.read }
      #=> IOError: closed stream

Note that some IO failures raise `SystemCallError`s and these are not
subclasses of IOError:

    File.open("does/not/exist")
      #=> Errno::ENOENT: No such file or directory - does/not/exist

[IOError Reference](http://ruby-doc.org/core-2.5.0/IOError.html)
