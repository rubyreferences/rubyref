# Fcntl

Fcntl loads the constants defined in the system's <fcntl.h> C header
file, and used with both the fcntl(2) and open(2) POSIX system
calls.</fcntl.h>

To perform a fcntl(2) operation, use IO::fcntl.

To perform an open(2) operation, use IO::sysopen.

The set of operations and constants available depends upon specific
operating system. Some values listed below may not be supported on your
system.

See your fcntl(2) man page for complete details.

Open /tmp/tempfile as a write-only file that is created if it doesn't
exist:


```ruby
require 'fcntl'

fd = IO.sysopen('/tmp/tempfile',
                Fcntl::O_WRONLY | Fcntl::O_EXCL | Fcntl::O_CREAT)
f = IO.open(fd)
f.syswrite("TEMP DATA")
f.close
```

Get the flags on file `s`: 

```ruby
m = s.fcntl(Fcntl::F_GETFL, 0)
```

Set the non-blocking flag on `f` in addition to the existing flags in
`m`.


```ruby
f.fcntl(Fcntl::F_SETFL, Fcntl::O_NONBLOCK|m)
```

[Fcntl
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/fcntl/rdoc/Fcntl.html)

