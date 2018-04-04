---
title: 'io/*: IO class addons'
prev: "/stdlib/cli/fcntl.html"
next: "/stdlib/cli/open3.html"
---

## `io/*` libraries

This family of libraries extends [IO](../../builtin/system-cli/io.md)
class with several methods.


```ruby
require 'io/console'
```

Extend IO with class and instance methods for working with terminal
console.

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/io/console/rdoc/IO.html'
class='ruby-doc remote' target='_blank'>io/console Reference</a>


```ruby
require 'io/nonblock'
```

Extends IO with `#nonblock`, `#nonblock=` and `#nonblock?` instance
methods for using IO object in nonblocking mode.

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/io/nonblock/rdoc/IO.html'
class='ruby-doc remote' target='_blank'>io/nonblock Reference</a>


```ruby
require 'io/wait'
```

Extends IO for methods to wait until it is readable or writable, without
blocking.

<a href='https://ruby-doc.org/stdlib-2.5.0/libdoc/io/wait/rdoc/IO.html'
class='ruby-doc remote' target='_blank'>io/wait Reference</a>

