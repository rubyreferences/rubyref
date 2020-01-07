---
title: 'resolv: DNS Resolver'
prev: "/stdlib/networking-web/openuri.html"
next: "/stdlib/networking-web/socket.html"
---


```ruby
require 'resolv'
```

## Resolv[](#resolv)

Resolv is a thread-aware DNS resolver library written in Ruby. Resolv can handle multiple DNS requests concurrently without blocking the entire Ruby interpreter.

See also resolv-replace.rb to replace the libc resolver with Resolv.

Resolv can look up various DNS resources using the DNS module directly.

Examples:


```ruby
p Resolv.getaddress "www.ruby-lang.org"
p Resolv.getname "210.251.121.214"

Resolv::DNS.open do |dns|
  ress = dns.getresources "www.ruby-lang.org", Resolv::DNS::Resource::IN::A
  p ress.map(&:address)
  ress = dns.getresources "ruby-lang.org", Resolv::DNS::Resource::IN::MX
  p ress.map { |r| [r.exchange.to_s, r.preference] }
end
```

<a href='https://ruby-doc.org/stdlib-2.7.0/libdoc/resolv/rdoc/Resolv.html' class='ruby-doc remote' target='_blank'>Resolv Reference</a>



