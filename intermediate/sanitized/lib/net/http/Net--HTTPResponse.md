# Net::HTTPResponse

HTTP response class.

This class wraps together the response header and the response body (the
entity requested).

It mixes in the HTTPHeader module, which provides access to response header
values both via hash-like methods and via individual readers.

Note that each possible HTTP response code defines its own HTTPResponse
subclass.  These are listed below.

All classes are defined under the Net module. Indentation indicates
inheritance.  For a list of the classes see Net::HTTP.

[Net::HTTPResponse Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/net/http/rdoc/Net::HTTPResponse.html)