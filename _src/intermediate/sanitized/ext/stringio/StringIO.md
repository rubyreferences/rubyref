# StringIO

Pseudo I/O on String object, with interface corresponding to IO.

Commonly used to simulate `$stdio` or `$stderr`

### Examples

    require 'stringio'

    # Writing stream emulation
    io = StringIO.new
    io.puts "Hello World"
    io.string #=> "Hello World\n"

    # Reading stream emulation
    io = StringIO.new "first\nsecond\nlast\n"
    io.getc #=> "f"
    io.gets #=> "irst\n"
    io.read #=> "second\nlast\n"

[StringIO Reference](https://ruby-doc.org/stdlib-2.7.0/libdoc/stringio/rdoc/StringIO.html)