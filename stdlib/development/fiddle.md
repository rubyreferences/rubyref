---
title: 'fiddle: FFI wrapper'
prev: "/stdlib/development/debug.html"
next: "/stdlib/development/logger.html"
---


```ruby
require 'fiddle'
```

## Fiddle[](#fiddle)

Fiddle is an extension to translate a foreign function interface (FFI)
with ruby.

It wraps <a href='http://sourceware.org/libffi/' class='remote'
target='_blank'>libffi</a>, a popular C library which provides a
portable interface that allows code written in one language to call code
written in another language.

### Example[](#example)

Here we will use Fiddle::Function to wrap <a
href='http://linux.die.net/man/3/floor' class='remote'
target='_blank'>floor(3) from libm</a>


```ruby
require 'fiddle'

libm = Fiddle.dlopen('/lib/libm.so.6')

floor = Fiddle::Function.new(
  libm['floor'],
  [Fiddle::TYPE_DOUBLE],
  Fiddle::TYPE_DOUBLE
)

puts floor.call(3.14159) #=> 3.0
```

<a href='https://ruby-doc.org/stdlib-2.6/libdoc/fiddle/rdoc/Fiddle.html'
class='ruby-doc remote' target='_blank'>Fiddle Reference</a>

