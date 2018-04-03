---
title: ipaddr
prev: "/stdlib/networking-web/cgi.html"
next: "/stdlib/networking-web/net/ftp.html"
---


```ruby
require 'ipaddr'
```

# IPAddr

IPAddr provides a set of methods to manipulate an IP address. Both IPv4
and IPv6 are supported.


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

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/ipaddr/rdoc/IPAddr.html'
class='ruby-doc remote reference' target='_blank'>IPAddr Reference</a>

