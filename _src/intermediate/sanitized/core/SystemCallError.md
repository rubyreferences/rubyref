# SystemCallError

SystemCallError is the base class for all low-level platform-dependent errors.

The errors available on the current platform are subclasses of SystemCallError
and are defined in the Errno module.

    File.open("does/not/exist")

*raises the exception:*

    Errno::ENOENT: No such file or directory - does/not/exist

[SystemCallError Reference](https://ruby-doc.org/core-2.5.0/SystemCallError.html)