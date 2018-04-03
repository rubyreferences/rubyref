# LoadError

Raised when a file required (a Ruby script, extension library, ...) fails to
load.

    require 'this/file/does/not/exist'

*raises the exception:*

    LoadError: no such file to load -- this/file/does/not/exist

[LoadError Reference](https://ruby-doc.org/core-2.5.0/LoadError.html)
