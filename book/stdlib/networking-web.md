# CGI

## Overview

The Common Gateway Interface (CGI) is a simple protocol for passing an
HTTP request from a web server to a standalone program, and returning
the output to the web browser. Basically, a CGI program is called with
the parameters of the request passed in either in the environment (GET)
or via $stdin (POST), and everything it prints to $stdout is returned to
the client.

This file holds the CGI class. This class provides functionality for
retrieving HTTP request parameters, managing cookies, and generating
HTML output.

The file CGI::Session provides session management functionality; see
that class for more details.

See http://www.w3.org/CGI/ for more information on the CGI protocol.

## Introduction

CGI is a large class, providing several categories of methods, many of
which are mixed in from other modules. Some of the documentation is in
this class, some in the modules CGI::QueryExtension and
CGI::HtmlExtension. See CGI::Cookie for specific information on handling
cookies, and cgi/session.rb (CGI::Session) for information on sessions.

For queries, CGI provides methods to get at environmental variables,
parameters, cookies, and multipart request data. For responses, CGI
provides methods for writing output and generating HTML.

Read on for more details. Examples are provided at the bottom.

## Queries

The CGI class dynamically mixes in parameter and cookie-parsing
functionality, environmental variable access, and support for parsing
multipart requests (including uploaded files) from the
CGI::QueryExtension module.

### Environmental Variables

The standard CGI environmental variables are available as read-only
attributes of a CGI object. The following is a list of these variables:


```ruby
AUTH_TYPE               HTTP_HOST          REMOTE_IDENT
CONTENT_LENGTH          HTTP_NEGOTIATE     REMOTE_USER
CONTENT_TYPE            HTTP_PRAGMA        REQUEST_METHOD
GATEWAY_INTERFACE       HTTP_REFERER       SCRIPT_NAME
HTTP_ACCEPT             HTTP_USER_AGENT    SERVER_NAME
HTTP_ACCEPT_CHARSET     PATH_INFO          SERVER_PORT
HTTP_ACCEPT_ENCODING    PATH_TRANSLATED    SERVER_PROTOCOL
HTTP_ACCEPT_LANGUAGE    QUERY_STRING       SERVER_SOFTWARE
HTTP_CACHE_CONTROL      REMOTE_ADDR
HTTP_FROM               REMOTE_HOST
```

For each of these variables, there is a corresponding attribute with the
same name, except all lower case and without a preceding HTTP\_.
`content_length` and `server_port` are integers; the rest are strings.

### Parameters

The method `#params`() returns a hash of all parameters in the request
as name/value-list pairs, where the value-list is an Array of one or
more values. The CGI object itself also behaves as a hash of parameter
names to values, but only returns a single value (as a String) for each
parameter name.

For instance, suppose the request contains the parameter
"favourite\_colours" with the multiple values "blue" and "green". The
following behavior would occur:


```ruby
cgi.params["favourite_colours"]  # => ["blue", "green"]
cgi["favourite_colours"]         # => "blue"
```

If a parameter does not exist, the former method will return an empty
array, the latter an empty string. The simplest way to test for
existence of a parameter is by the `#has_key?` method.

### Cookies

HTTP Cookies are automatically parsed from the request. They are
available from the `#cookies`() accessor, which returns a hash from
cookie name to CGI::Cookie object.

### Multipart requests

If a request's method is POST and its content type is
multipart/form-data, then it may contain uploaded files. These are
stored by the QueryExtension module in the parameters of the request.
The parameter name is the name attribute of the file input field, as
usual. However, the value is not a string, but an IO object, either an
IOString for small files, or a Tempfile for larger ones. This object
also has the additional singleton methods:

* `#local_path`(): the path of the uploaded file on the local filesystem

* `#original_filename`(): the name of the file on the client computer
* `#content_type`(): the content type of the file

## Responses

The CGI class provides methods for sending header and content output to
the HTTP client, and mixes in methods for programmatic HTML generation
from CGI::HtmlExtension and CGI::TagMaker modules. The precise version
of HTML to use for HTML generation is specified at object creation time.

### Writing output

The simplest way to send output to the HTTP client is using the `#out`()
method. This takes the HTTP headers as a hash parameter, and the body
content via a block. The headers can be generated as a string using the
`#http_header`() method. The output stream can be written directly to
using the `#print`() method.

### Generating HTML

Each HTML element has a corresponding method for generating that element
as a String. The name of this method is the same as that of the element,
all lowercase. The attributes of the element are passed in as a hash,
and the body as a no-argument block that evaluates to a String. The HTML
generation module knows which elements are always empty, and silently
drops any passed-in body. It also knows which elements require matching
closing tags and which don't. However, it does not know what attributes
are legal for which elements.

There are also some additional HTML generation methods mixed in from the
CGI::HtmlExtension module. These include individual methods for the
different types of form inputs, and methods for elements that commonly
take particular attributes where the attributes can be directly
specified as arguments, rather than via a hash.

### Utility HTML escape and other methods like a function.

There are some utility tool defined in cgi/util.rb . And when include,
you can use utility methods like a function.

## Examples of use

### Get form values


```ruby
require "cgi"
cgi = CGI.new
value = cgi['field_name']   # <== value string for 'field_name'
  # if not 'field_name' included, then return "".
fields = cgi.keys            # <== array of field names

# returns true if form has 'field_name'
cgi.has_key?('field_name')
cgi.has_key?('field_name')
cgi.include?('field_name')
```

CAUTION! [cgi]('field_name') returned an Array with the old
cgi.rb(included in Ruby 1.6)

### Get form values as hash


```ruby
require "cgi"
cgi = CGI.new
params = cgi.params
```

cgi.params is a hash.


```ruby
cgi.params['new_field_name'] = ["value"]  # add new param
cgi.params['field_name'] = ["new_value"]  # change value
cgi.params.delete('field_name')           # delete param
cgi.params.clear                          # delete all params
```

### Save form values to file


```ruby
require "pstore"
db = PStore.new("query.db")
db.transaction do
  db["params"] = cgi.params
end
```

### Restore form values from file


```ruby
require "pstore"
db = PStore.new("query.db")
db.transaction do
  cgi.params = db["params"]
end
```

### Get multipart form values


```ruby
require "cgi"
cgi = CGI.new
value = cgi['field_name']   # <== value string for 'field_name'
value.read                  # <== body of value
value.local_path            # <== path to local file of value
value.original_filename     # <== original filename of value
value.content_type          # <== content_type of value
```

and value has StringIO or Tempfile class methods.

### Get cookie values


```ruby
require "cgi"
cgi = CGI.new
values = cgi.cookies['name']  # <== array of 'name'
  # if not 'name' included, then return [].
names = cgi.cookies.keys      # <== array of cookie names
```

and cgi.cookies is a hash.

### Get cookie objects


```ruby
require "cgi"
cgi = CGI.new
for name, cookie in cgi.cookies
  cookie.expires = Time.now + 30
end
cgi.out("cookie" => cgi.cookies) {"string"}

cgi.cookies # { "name1" => cookie1, "name2" => cookie2, ... }

require "cgi"
cgi = CGI.new
cgi.cookies['name'].expires = Time.now + 30
cgi.out("cookie" => cgi.cookies['name']) {"string"}
```

### Print http header and html string to $DEFAULT\_OUTPUT ($>)


```ruby
require "cgi"
cgi = CGI.new("html4")  # add HTML generation methods
cgi.out do
  cgi.html do
    cgi.head do
      cgi.title { "TITLE" }
    end +
    cgi.body do
      cgi.form("ACTION" => "uri") do
        cgi.p do
          cgi.textarea("get_text") +
          cgi.br +
          cgi.submit
        end
      end +
      cgi.pre do
        CGI::escapeHTML(
          "params: #{cgi.params.inspect}\n" +
          "cookies: #{cgi.cookies.inspect}\n" +
          ENV.collect do |key, value|
            "#{key} --> #{value}\n"
          end.join("")
        )
      end
    end
  end
end

# add HTML generation methods
CGI.new("html3")    # html3.2
CGI.new("html4")    # html4.01 (Strict)
CGI.new("html4Tr")  # html4.01 Transitional
CGI.new("html4Fr")  # html4.01 Frameset
CGI.new("html5")    # html5
```

### Some utility methods


```ruby
require 'cgi/util'
CGI.escapeHTML('Usage: foo "bar" <baz>')
```

### Some utility methods like a function


```ruby
require 'cgi/util'
include CGI::Util
escapeHTML('Usage: foo "bar" <baz>')
h('Usage: foo "bar" <baz>') # alias
```



## URI

URI is a module providing classes to handle Uniform Resource Identifiers
([RFC2396][1])

### Features

* Uniform handling of handling URIs

* Flexibility to introduce custom URI schemes
* Flexibility to have an alternate URI::Parser (or just different
  patterns and regexp's)

### Basic example


```ruby
require 'uri'

uri = URI("http://foo.com/posts?id=30&limit=5#time=1305298413")
#=> #<URI::HTTP:0x00000000b14880
      URL:http://foo.com/posts?id=30&limit=5#time=1305298413>
uri.scheme
#=> "http"
uri.host
#=> "foo.com"
uri.path
#=> "/posts"
uri.query
#=> "id=30&limit=5"
uri.fragment
#=> "time=1305298413"

uri.to_s
#=> "http://foo.com/posts?id=30&limit=5#time=1305298413"
```

### Adding custom URIs


```ruby
module URI
  class RSYNC < Generic
    DEFAULT_PORT = 873
  end
  @@schemes['RSYNC'] = RSYNC
end
#=> URI::RSYNC

URI.scheme_list
#=> {"FILE"=>URI::File, "FTP"=>URI::FTP, "HTTP"=>URI::HTTP, "HTTPS"=>URI::HTTPS,
     "LDAP"=>URI::LDAP, "LDAPS"=>URI::LDAPS, "MAILTO"=>URI::MailTo,
     "RSYNC"=>URI::RSYNC}

uri = URI("rsync://rsync.foo.com")
#=> #<URI::RSYNC:0x00000000f648c8 URL:rsync://rsync.foo.com>
```

### RFC References

A good place to view an RFC spec is http://www.ietf.org/rfc.html

Here is a list of all related RFC's.

* [RFC822][2]
* [RFC1738][3]
* [RFC2255][4]
* [RFC2368][5]
* [RFC2373][6]
* [RFC2396][1]
* [RFC2732][7]
* [RFC3986][8]

### Class tree

* URI::Generic (in uri/generic.rb)
  * URI::File - (in uri/file.rb)
  * URI::FTP - (in uri/ftp.rb)
  * URI::HTTP - (in uri/http.rb)
    * URI::HTTPS - (in uri/https.rb)
  
  * URI::LDAP - (in uri/ldap.rb)
    * URI::LDAPS - (in uri/ldaps.rb)
  
  * URI::MailTo - (in uri/mailto.rb)

* URI::Parser - (in uri/common.rb)

* URI::REGEXP - (in uri/common.rb)
  * URI::REGEXP::PATTERN - (in uri/common.rb)

* URI::Util - (in uri/common.rb)

* URI::Escape - (in uri/common.rb)
* URI::Error - (in uri/common.rb)
  * URI::InvalidURIError - (in uri/common.rb)
  * URI::InvalidComponentError - (in uri/common.rb)
  * URI::BadURIError - (in uri/common.rb)

### Copyright Info

* Author: Akira Yamada [akira@ruby-lang.org](mailto:akira@ruby-lang.org)

* Documentation: Akira Yamada
  [akira@ruby-lang.org](mailto:akira@ruby-lang.org) Dmitry V. Sabanin
  [sdmitry@lrn.ru](mailto:sdmitry@lrn.ru) Vincent Batts
  [vbatts@hashbangbash.com](mailto:vbatts@hashbangbash.com)

* License: Copyright (c) 2001 akira yamada
  [akira@ruby-lang.org](mailto:akira@ruby-lang.org) You can redistribute
  it and/or modify it under the same term as Ruby.

* Revision: $Id$



[1]: http://tools.ietf.org/html/rfc2396
[2]: http://tools.ietf.org/html/rfc822
[3]: http://tools.ietf.org/html/rfc1738
[4]: http://tools.ietf.org/html/rfc2255
[5]: http://tools.ietf.org/html/rfc2368
[6]: http://tools.ietf.org/html/rfc2373
[7]: http://tools.ietf.org/html/rfc2732
[8]: http://tools.ietf.org/html/rfc3986


## OpenURI

OpenURI is an easy-to-use wrapper for Net::HTTP, Net::HTTPS and
Net::FTP.

### Example

It is possible to open an http, https or ftp URL as though it were a
file:


```ruby
open("http://www.ruby-lang.org/") {|f|
  f.each_line {|line| p line}
}
```

The opened file has several getter methods for its meta-information, as
follows, since it is extended by OpenURI::Meta.


```ruby
open("http://www.ruby-lang.org/en") {|f|
  f.each_line {|line| p line}
  p f.base_uri         # <URI::HTTP:0x40e6ef2 URL:http://www.ruby-lang.org/en/>
  p f.content_type     # "text/html"
  p f.charset          # "iso-8859-1"
  p f.content_encoding # []
  p f.last_modified    # Thu Dec 05 02:45:02 UTC 2002
}
```

Additional header fields can be specified by an optional hash argument.


```ruby
open("http://www.ruby-lang.org/en/",
  "User-Agent" => "Ruby/#{RUBY_VERSION}",
  "From" => "foo@bar.invalid",
  "Referer" => "http://www.ruby-lang.org/") {|f|
  # ...
}
```

The environment variables such as http\_proxy, https\_proxy and
ftp\_proxy are in effect by default. Here we disable proxy:


```ruby
open("http://www.ruby-lang.org/en/", :proxy => nil) {|f|
  # ...
}
```

See OpenURI::OpenRead.open and `Kernel#open` for more on available
options.

URI objects can be opened in a similar way.


```ruby
uri = URI.parse("http://www.ruby-lang.org/en/")
uri.open {|f|
  # ...
}
```

URI objects can be read directly. The returned string is also extended
by OpenURI::Meta.


```ruby
str = uri.read
p str.base_uri
```

* Author: Tanaka Akira [akr@m17n.org](mailto:akr@m17n.org)



## IPAddr

IPAddr provides a set of methods to manipulate an IP address. Both IPv4
and IPv6 are supported.

### Example


```ruby
require 'ipaddr'

ipaddr1 = IPAddr.new "3ffe:505:2::1"

p ipaddr1                   #=> #<IPAddr: IPv6:3ffe:0505:0002:0000:0000:0000:0000:0001/ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff>

p ipaddr1.to_s              #=> "3ffe:505:2::1"

ipaddr2 = ipaddr1.mask(48)  #=> #<IPAddr: IPv6:3ffe:0505:0002:0000:0000:0000:0000:0000/ffff:ffff:ffff:0000:0000:0000:0000:0000>

p ipaddr2.to_s              #=> "3ffe:505:2::"

ipaddr3 = IPAddr.new "192.168.2.0/24"

p ipaddr3                   #=> #<IPAddr: IPv4:192.168.2.0/255.255.255.0>
```



## WEBrick

## WEB server toolkit.

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

### Servlets

Advanced custom behavior can be obtained through mounting a subclass of
WEBrick::HTTPServlet::AbstractServlet. Servlets provide more modularity
when writing an HTTP server than mount\_proc allows. Here is a simple
servlet:


```ruby
class Simple < WEBrick::HTTPServlet::AbstractServlet
  def do_GET request, response
    status, content_type, body = do_stuff_with request

    response.status = 200
    response['Content-Type'] = 'text/plain'
    response.body = 'Hello, World!'
  end
end
```

To initialize the servlet you mount it on the server:


```ruby
server.mount '/simple', Simple
```

See WEBrick::HTTPServlet::AbstractServlet for more details.

### Virtual Hosts

A server can act as a virtual host for multiple host names. After
creating the listening host, additional hosts that do not listen can be
created and attached as virtual hosts:


```ruby
server = WEBrick::HTTPServer.new # ...

vhost = WEBrick::HTTPServer.new :ServerName => 'vhost.example',
                                :DoNotListen => true, # ...
vhost.mount '/', ...

server.virtual_host vhost
```

If no `:DocumentRoot` is provided and no servlets or procs are mounted
on the main server it will return 404 for all URLs.

### HTTPS

To create an HTTPS server you only need to enable SSL and provide an SSL
certificate name:


```ruby
require 'webrick'
require 'webrick/https'

cert_name = [
  %w[CN localhost],
]

server = WEBrick::HTTPServer.new(:Port => 8000,
                                 :SSLEnable => true,
                                 :SSLCertName => cert_name)
```

This will start the server with a self-generated self-signed
certificate. The certificate will be changed every time the server is
restarted.

To create a server with a pre-determined key and certificate you can
provide them:


```ruby
require 'webrick'
require 'webrick/https'
require 'openssl'

cert = OpenSSL::X509::Certificate.new File.read '/path/to/cert.pem'
pkey = OpenSSL::PKey::RSA.new File.read '/path/to/pkey.pem'

server = WEBrick::HTTPServer.new(:Port => 8000,
                                 :SSLEnable => true,
                                 :SSLCertificate => cert,
                                 :SSLPrivateKey => pkey)
```

### Proxy Server

WEBrick can act as a proxy server:


```ruby
require 'webrick'
require 'webrick/httpproxy'

proxy = WEBrick::HTTPProxyServer.new :Port => 8000

trap 'INT' do proxy.shutdown end
```

See WEBrick::HTTPProxy for further details including modifying proxied
responses.

### Basic and Digest authentication

WEBrick provides both Basic and Digest authentication for regular and
proxy servers. See WEBrick::HTTPAuth, WEBrick::HTTPAuth::BasicAuth and
WEBrick::HTTPAuth::DigestAuth.

### WEBrick as a Production Web Server

WEBrick can be run as a production server for small loads.

#### Daemonizing

To start a WEBrick server as a daemon simple run WEBrick::Daemon.start
before starting the server.

#### Dropping Permissions

WEBrick can be started as one user to gain permission to bind to port 80
or 443 for serving HTTP or HTTPS traffic then can drop these permissions
for regular operation. To listen on all interfaces for HTTP traffic:


```ruby
sockets = WEBrick::Utils.create_listeners nil, 80
```

Then drop privileges:


```ruby
WEBrick::Utils.su 'www'
```

Then create a server that does not listen by default:


```ruby
server = WEBrick::HTTPServer.new :DoNotListen => true, # ...
```

Then overwrite the listening sockets with the port 80 sockets:


```ruby
server.listeners.replace sockets
```

#### Logging

WEBrick can separately log server operations and end-user access. For
server operations:


```ruby
log_file = File.open '/var/log/webrick.log', 'a+'
log = WEBrick::Log.new log_file
```

For user access logging:


```ruby
access_log = [
  [log_file, WEBrick::AccessLog::COMBINED_LOG_FORMAT],
]

server = WEBrick::HTTPServer.new :Logger => log, :AccessLog => access_log
```

See WEBrick::AccessLog for further log formats.

#### Log Rotation

To rotate logs in WEBrick on a HUP signal (like syslogd can send), open
the log file in 'a+' mode (as above) and trap 'HUP' to reopen the log
file:


```ruby
trap 'HUP' do log_file.reopen '/path/to/webrick.log', 'a+'
```

### Copyright

Author: IPR -- Internet Programming with Ruby -- writers

Copyright (c) 2000 TAKAHASHI Masayoshi, GOTOU YUUZOU Copyright (c) 2002
Internet Programming with Ruby writers. All rights reserved.



## Socket

Class `Socket` provides access to the underlying operating system socket
implementations. It can be used to provide more operating system
specific functionality than the protocol-specific socket classes.

The constants defined under Socket::Constants are also defined under
Socket. For example, Socket::AF\_INET is usable as well as
Socket::Constants::AF\_INET. See Socket::Constants for the list of
constants.

#### What's a socket?

Sockets are endpoints of a bidirectional communication channel. Sockets
can communicate within a process, between processes on the same machine
or between different machines. There are many types of socket:
TCPSocket, UDPSocket or UNIXSocket for example.

Sockets have their own vocabulary:

**domain:** The family of protocols:

* Socket::PF\_INET
* Socket::PF\_INET6
* Socket::PF\_UNIX
* etc.

**type:** The type of communications between the two endpoints,
typically

* Socket::SOCK\_STREAM
* Socket::SOCK\_DGRAM.

**protocol:** Typically *zero*. This may be used to identify a variant
of a protocol.

**hostname:** The identifier of a network interface:

* a string (hostname, IPv4 or IPv6 address or `broadcast` which
  specifies a broadcast address)

* a zero-length string which specifies INADDR\_ANY
* an integer (interpreted as binary address in host byte order).

#### Quick start

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

#### Exception Handling

Ruby's Socket implementation raises exceptions based on the error
generated by the system dependent implementation. This is why the
methods are documented in a way that isolate Unix-based system
exceptions from Windows based exceptions. If more information on a
particular exception is needed, please refer to the Unix manual pages or
the Windows WinSock reference.

#### Convenience methods

Although the general way to create socket is Socket.new, there are
several methods of socket creation for most cases.

* TCP client socket: Socket.tcp, TCPSocket.open

* TCP server socket: Socket.tcp\_server\_loop, TCPServer.open
* UNIX client socket: Socket.unix, UNIXSocket.open
* UNIX server socket: Socket.unix\_server\_loop, UNIXServer.open

#### Documentation by

* Zach Dennis

* Sam Roberts
* *Programming Ruby* from The Pragmatic Bookshelf.

Much material in this documentation is taken with permission from
*Programming Ruby* from The Pragmatic Bookshelf.

