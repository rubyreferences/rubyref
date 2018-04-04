---
title: socket
prev: "/stdlib/networking-web/resolv.html"
next: "/stdlib/networking-web/webrick.html"
---


```ruby
require 'socket'
```

# Socket

Class `Socket` provides access to the underlying operating system socket
implementations. It can be used to provide more operating system
specific functionality than the protocol-specific socket classes.

The constants defined under Socket::Constants are also defined under
Socket. For example, Socket::AF\_INET is usable as well as
Socket::Constants::AF\_INET. See Socket::Constants for the list of
constants.

### Quick start

Many of the classes, such as TCPSocket, UDPSocket or UNIXSocket, ease
the use of sockets comparatively to the equivalent C programming
interface.

Let's create an internet socket using the IPv4 protocol in a C-like
manner:


```ruby
require 'socket'

s = Socket.new Socket::AF_INET, Socket::SOCK_STREAM
s.connect Socket.pack_sockaddr_in(80, 'example.com')
```

You could also use the TCPSocket class:


```ruby
s = TCPSocket.new 'example.com', 80
```

A simple server might look like this:


```ruby
require 'socket'

server = TCPServer.new 2000 # Server bound to port 2000

loop do
  client = server.accept    # Wait for a client to connect
  client.puts "Hello !"
  client.puts "Time is #{Time.now}"
  client.close
end
```

A simple client may look like this:


```ruby
require 'socket'

s = TCPSocket.new 'localhost', 2000

while line = s.gets # Read lines from socket
  puts line         # and print them
end

s.close             # close socket when done
```

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/socket/rdoc/Socket.html'
class='ruby-doc remote' target='_blank'>Socket Reference</a>

