# StringIO

Pseudo I/O on String object.

Commonly used to simulate `$stdio` or `$stderr`

### Examples

    require 'stringio'

    io = StringIO.new
    io.puts "Hello World"
    io.string #=> "Hello World\n"

[StringIO Reference](https://ruby-doc.org/stdlib-2.6/libdoc/stringio/rdoc/StringIO.html)