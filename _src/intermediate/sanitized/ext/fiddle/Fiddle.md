# Fiddle

A libffi wrapper for Ruby.

## Description

Fiddle is an extension to translate a foreign function interface (FFI) with
ruby.

It wraps [libffi](http://sourceware.org/libffi/), a popular C library which
provides a portable interface that allows code written in one language to call
code written in another language.

## Example

Here we will use Fiddle::Function to wrap [floor(3) from
libm](http://linux.die.net/man/3/floor)

    require 'fiddle'

    libm = Fiddle.dlopen('/lib/libm.so.6')

    floor = Fiddle::Function.new(
      libm['floor'],
      [Fiddle::TYPE_DOUBLE],
      Fiddle::TYPE_DOUBLE
    )

    puts floor.call(3.14159) #=> 3.0

[Fiddle Reference](https://ruby-doc.org/stdlib-2.7.0/libdoc/fiddle/rdoc/Fiddle.html)