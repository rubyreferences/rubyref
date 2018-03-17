# StringIO

Pseudo I/O on String object.

Commonly used to simulate `$stdio` or `$stderr`

### Examples

    require 'stringio'

    io = StringIO.new
    io.puts "Hello World"
    io.string #=> "Hello World\n"
