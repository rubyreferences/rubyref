# TCPSocket

TCPSocket represents a TCP/IP client socket.

A simple client may look like:

    require 'socket'

    s = TCPSocket.new 'localhost', 2000

    while line = s.gets # Read lines from socket
      puts line         # and print them
    end

    s.close             # close socket when done

[TCPSocket Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/socket/rdoc/TCPSocket.html)