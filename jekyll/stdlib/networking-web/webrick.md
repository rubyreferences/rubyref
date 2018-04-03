---
title: 'webrick: Simple Web Server'
prev: "/stdlib/networking-web/socket.html"
next: "/stdlib/networking-web/uri.html"
---


```ruby
require 'webrick'
```

# WEB server toolkit.

WEBrick is an HTTP server toolkit that can be configured as an HTTPS
server, a proxy server, and a virtual-host server. WEBrick features
complete logging of both server operations and HTTP access. WEBrick
supports both basic and digest authentication in addition to algorithms
not in RFC 2617.

A WEBrick server can be composed of multiple WEBrick servers or servlets
to provide differing behavior on a per-host or per-path basis. WEBrick
includes servlets for handling CGI scripts, ERB pages, Ruby blocks and
directory listings.

WEBrick also includes tools for daemonizing a process and starting a
process at a higher privilege level and dropping permissions.



### Starting an HTTP server

To create a new WEBrick::HTTPServer that will listen to connections on
port 8000 and serve documents from the current user's public\_html
folder:


```ruby
require 'webrick'

root = File.expand_path '~/public_html'
server = WEBrick::HTTPServer.new :Port => 8000, :DocumentRoot => root
```

To run the server you will need to provide a suitable shutdown hook as
starting the server blocks the current thread:


```ruby
trap 'INT' do server.shutdown end

server.start
```



### Custom Behavior

The easiest way to have a server perform custom operations is through
W`EBrick::HTTPServer#mount_proc`. The block given will be called with a
WEBrick::HTTPRequest with request info and a WEBrick::HTTPResponse which
must be filled in appropriately:


```ruby
server.mount_proc '/' do |req, res|
  res.body = 'Hello, world!'
end
```

Remember that `server.mount_proc` must precede `server.start`.



<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/webrick/rdoc/WEBrick.html'
class='ruby-doc remote reference' target='_blank'>WEBrick Reference</a>

