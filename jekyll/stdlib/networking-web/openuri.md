---
title: 'openuri: Open Files and URLs'
prev: "/stdlib/networking-web/net/smtp.html"
next: "/stdlib/networking-web/resolv.html"
---


```ruby
require 'open-uri'
```

# OpenURI

OpenURI is an easy-to-use wrapper for Net::HTTP, Net::HTTPS and
Net::FTP.

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

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/open-uri/rdoc/OpenURI.html'
class='ruby-doc remote reference' target='_blank'>OpenURI Reference</a>

