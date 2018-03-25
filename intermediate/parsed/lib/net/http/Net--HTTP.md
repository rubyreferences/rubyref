# Net::HTTP

## An HTTP client API for Ruby.

Net::HTTP provides a rich library which can be used to build HTTP user-agents.
 For more details about HTTP see
[RFC2616](http://www.ietf.org/rfc/rfc2616.txt)

Net::HTTP is designed to work closely with URI.  URI::HTTP#host,
URI::HTTP#port and URI::HTTP#request_uri are designed to work with Net::HTTP.

If you are only performing a few GET requests you should try OpenURI.

## Simple Examples

All examples assume you have loaded Net::HTTP with:

    require 'net/http'

This will also require 'uri' so you don't need to require it separately.

The Net::HTTP methods in the following section do not persist connections. 
They are not recommended if you are performing many HTTP requests.

### GET

    Net::HTTP.get('example.com', '/index.html') # => String

### GET by URI

    uri = URI('http://example.com/index.html?count=10')
    Net::HTTP.get(uri) # => String

### GET with Dynamic Parameters

    uri = URI('http://example.com/index.html')
    params = { :limit => 10, :page => 3 }
    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)
    puts res.body if res.is_a?(Net::HTTPSuccess)

### POST

    uri = URI('http://www.example.com/search.cgi')
    res = Net::HTTP.post_form(uri, 'q' => 'ruby', 'max' => '50')
    puts res.body

### POST with Multiple Values

    uri = URI('http://www.example.com/search.cgi')
    res = Net::HTTP.post_form(uri, 'q' => ['ruby', 'perl'], 'max' => '50')
    puts res.body

## How to use Net::HTTP

The following example code can be used as the basis of a HTTP user-agent which
can perform a variety of request types using persistent connections.

    uri = URI('http://example.com/some_path?query=string')

    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Get.new uri

      response = http.request request # Net::HTTPResponse object
    end

Net::HTTP::start immediately creates a connection to an HTTP server which is
kept open for the duration of the block.  The connection will remain open for
multiple requests in the block if the server indicates it supports persistent
connections.

If you wish to re-use a connection across multiple HTTP requests without
automatically closing it you can use ::new and then call #start and #finish
manually.

The request types Net::HTTP supports are listed below in the section "HTTP
Request Classes".

For all the Net::HTTP request objects and shortcut request methods you may
supply either a String for the request path or a URI from which Net::HTTP will
extract the request path.

### Response Data

    uri = URI('http://example.com/index.html')
    res = Net::HTTP.get_response(uri)

    # Headers
    res['Set-Cookie']            # => String
    res.get_fields('set-cookie') # => Array
    res.to_hash['set-cookie']    # => Array
    puts "Headers: #{res.to_hash.inspect}"

    # Status
    puts res.code       # => '200'
    puts res.message    # => 'OK'
    puts res.class.name # => 'HTTPOK'

    # Body
    puts res.body if res.response_body_permitted?

### Following Redirection

Each Net::HTTPResponse object belongs to a class for its response code.

For example, all 2XX responses are instances of a Net::HTTPSuccess subclass, a
3XX response is an instance of a Net::HTTPRedirection subclass and a 200
response is an instance of the Net::HTTPOK class.  For details of response
classes, see the section "HTTP Response Classes" below.

Using a case statement you can handle various types of responses properly:

    def fetch(uri_str, limit = 10)
      # You should choose a better exception.
      raise ArgumentError, 'too many HTTP redirects' if limit == 0

      response = Net::HTTP.get_response(URI(uri_str))

      case response
      when Net::HTTPSuccess then
        response
      when Net::HTTPRedirection then
        location = response['location']
        warn "redirected to #{location}"
        fetch(location, limit - 1)
      else
        response.value
      end
    end

    print fetch('http://www.ruby-lang.org')

### POST

A POST can be made using the Net::HTTP::Post request class.  This example
creates a urlencoded POST body:

    uri = URI('http://www.example.com/todo.cgi')
    req = Net::HTTP::Post.new(uri)
    req.set_form_data('from' => '2005-01-01', 'to' => '2005-03-31')

    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end

    case res
    when Net::HTTPSuccess, Net::HTTPRedirection
      # OK
    else
      res.value
    end

At this time Net::HTTP does not support multipart/form-data.  To send
multipart/form-data use Net::HTTPRequest#body= and
Net::HTTPRequest#content_type=:

    req = Net::HTTP::Post.new(uri)
    req.body = multipart_data
    req.content_type = 'multipart/form-data'

Other requests that can contain a body such as PUT can be created in the same
way using the corresponding request class (Net::HTTP::Put).

### Setting Headers

The following example performs a conditional GET using the If-Modified-Since
header.  If the files has not been modified since the time in the header a Not
Modified response will be returned.  See RFC 2616 section 9.3 for further
details.

    uri = URI('http://example.com/cached_response')
    file = File.stat 'cached_response'

    req = Net::HTTP::Get.new(uri)
    req['If-Modified-Since'] = file.mtime.rfc2822

    res = Net::HTTP.start(uri.hostname, uri.port) {|http|
      http.request(req)
    }

    open 'cached_response', 'w' do |io|
      io.write res.body
    end if res.is_a?(Net::HTTPSuccess)

### Basic Authentication

Basic authentication is performed according to
[RFC2617](http://www.ietf.org/rfc/rfc2617.txt)

    uri = URI('http://example.com/index.html?key=value')

    req = Net::HTTP::Get.new(uri)
    req.basic_auth 'user', 'pass'

    res = Net::HTTP.start(uri.hostname, uri.port) {|http|
      http.request(req)
    }
    puts res.body

### Streaming Response Bodies

By default Net::HTTP reads an entire response into memory.  If you are
handling large files or wish to implement a progress bar you can instead
stream the body directly to an IO.

    uri = URI('http://example.com/large_file')

    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Get.new uri

      http.request request do |response|
        open 'large_file', 'w' do |io|
          response.read_body do |chunk|
            io.write chunk
          end
        end
      end
    end

### HTTPS

HTTPS is enabled for an HTTP connection by Net::HTTP#use_ssl=.

    uri = URI('https://secure.example.com/some_path?query=string')

    Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
      request = Net::HTTP::Get.new uri
      response = http.request request # Net::HTTPResponse object
    end

Or if you simply want to make a GET request, you may pass in an URI object
that has a HTTPS URL. Net::HTTP automatically turn on TLS verification if the
URI object has a 'https' URI scheme.

    uri = URI('https://example.com/')
    Net::HTTP.get(uri) # => String

In previous versions of Ruby you would need to require 'net/https' to use
HTTPS. This is no longer true.

### Proxies

Net::HTTP will automatically create a proxy from the `http_proxy` environment
variable if it is present.  To disable use of `http_proxy`, pass `nil` for the
proxy address.

You may also create a custom proxy:

    proxy_addr = 'your.proxy.host'
    proxy_port = 8080

    Net::HTTP.new('example.com', nil, proxy_addr, proxy_port).start { |http|
      # always proxy via your.proxy.addr:8080
    }

See Net::HTTP.new for further details and examples such as proxies that
require a username and password.

### Compression

Net::HTTP automatically adds Accept-Encoding for compression of response
bodies and automatically decompresses gzip and deflate responses unless a
Range header was sent.

Compression can be disabled through the Accept-Encoding: identity header.

## HTTP Request Classes

Here is the HTTP request class hierarchy.

*   Net::HTTPRequest
    *   Net::HTTP::Get
    *   Net::HTTP::Head
    *   Net::HTTP::Post
    *   Net::HTTP::Patch
    *   Net::HTTP::Put
    *   Net::HTTP::Proppatch
    *   Net::HTTP::Lock
    *   Net::HTTP::Unlock
    *   Net::HTTP::Options
    *   Net::HTTP::Propfind
    *   Net::HTTP::Delete
    *   Net::HTTP::Move
    *   Net::HTTP::Copy
    *   Net::HTTP::Mkcol
    *   Net::HTTP::Trace



## HTTP Response Classes

Here is HTTP response class hierarchy.  All classes are defined in Net module
and are subclasses of Net::HTTPResponse.

HTTPUnknownResponse
:   For unhandled HTTP extensions
HTTPInformation
:   1xx
HTTPContinue
:   100
HTTPSwitchProtocol
:   101
HTTPSuccess
:   2xx
HTTPOK
:   200
HTTPCreated
:   201
HTTPAccepted
:   202
HTTPNonAuthoritativeInformation
:   203
HTTPNoContent
:   204
HTTPResetContent
:   205
HTTPPartialContent
:   206
HTTPMultiStatus
:   207
HTTPIMUsed
:   226
HTTPRedirection
:   3xx
HTTPMultipleChoices
:   300
HTTPMovedPermanently
:   301
HTTPFound
:   302
HTTPSeeOther
:   303
HTTPNotModified
:   304
HTTPUseProxy
:   305
HTTPTemporaryRedirect
:   307
HTTPClientError
:   4xx
HTTPBadRequest
:   400
HTTPUnauthorized
:   401
HTTPPaymentRequired
:   402
HTTPForbidden
:   403
HTTPNotFound
:   404
HTTPMethodNotAllowed
:   405
HTTPNotAcceptable
:   406
HTTPProxyAuthenticationRequired
:   407
HTTPRequestTimeOut
:   408
HTTPConflict
:   409
HTTPGone
:   410
HTTPLengthRequired
:   411
HTTPPreconditionFailed
:   412
HTTPRequestEntityTooLarge
:   413
HTTPRequestURITooLong
:   414
HTTPUnsupportedMediaType
:   415
HTTPRequestedRangeNotSatisfiable
:   416
HTTPExpectationFailed
:   417
HTTPUnprocessableEntity
:   422
HTTPLocked
:   423
HTTPFailedDependency
:   424
HTTPUpgradeRequired
:   426
HTTPPreconditionRequired
:   428
HTTPTooManyRequests
:   429
HTTPRequestHeaderFieldsTooLarge
:   431
HTTPUnavailableForLegalReasons
:   451
HTTPServerError
:   5xx
HTTPInternalServerError
:   500
HTTPNotImplemented
:   501
HTTPBadGateway
:   502
HTTPServiceUnavailable
:   503
HTTPGatewayTimeOut
:   504
HTTPVersionNotSupported
:   505
HTTPInsufficientStorage
:   507
HTTPNetworkAuthenticationRequired
:   511


There is also the Net::HTTPBadResponse exception which is raised when there is
a protocol error.

[Net::HTTP Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/net/http/rdoc/Net::HTTP.html)
