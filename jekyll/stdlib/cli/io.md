# `io/*` libraries

This family of libraries extends [IO](#TODO) class with several methods.


```ruby
require 'io/console'
```

Extend IO with class and instance methods for working with terminal
console.

[io/console Reference](ref:io/console/IO)


```ruby
require 'io/nonblock'
```

Extends IO with `#nonblock`, `#nonblock=` and `#nonblock?` instance
methods for using IO object in nonblocking mode.

[io/nonblock Reference](ref:io/nonblock/IO)


```ruby
require 'io/wait'
```

Extends IO for methods to wait until it is readable or writable, without
blocking.

[io/wait Reference](ref:io/wait/IO)

