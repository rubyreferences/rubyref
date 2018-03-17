# TCPServer

TCPServer represents a TCP/IP server socket.

A simple TCP server may look like:

    require 'socket'

    server = TCPServer.new 2000 # Server bind to port 2000
    loop do
      client = server.accept    # Wait for a client to connect
      client.puts "Hello !"
      client.puts "Time is #{Time.now}"
      client.close
    end

A more usable server (serving multiple clients):

    require 'socket'

    server = TCPServer.new 2000
    loop do
      Thread.start(server.accept) do |client|
        client.puts "Hello !"
        client.puts "Time is #{Time.now}"
        client.close
      end
    end