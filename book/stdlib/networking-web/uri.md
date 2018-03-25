
```ruby
require 'uri'
```

# URI

URI is a module providing classes to handle Uniform Resource Identifiers
([RFC2396](http://tools.ietf.org/html/rfc2396))

## Features

* Uniform handling of handling URIs
* Flexibility to introduce custom URI schemes
* Flexibility to have an alternate URI::Parser (or just different
  patterns and regexp's)

## Basic example


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

## Adding custom URIs


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

[URI
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/uri/rdoc/URI.html)

