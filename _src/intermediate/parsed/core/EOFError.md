# EOFError

Raised by some IO operations when reaching the end of file. Many IO methods
exist in two forms,

one that returns `nil` when the end of file is reached, the other raises
`EOFError`.

`EOFError` is a subclass of `IOError`.

    file = File.open("/etc/hosts")
    file.read
    file.gets     #=> nil
    file.readline #=> EOFError: end of file reached

[EOFError Reference](https://ruby-doc.org/core-2.5.0/EOFError.html)
