# ACL

Simple Access Control Lists.

Access control lists are composed of "allow" and "deny" halves to control
access.  Use "all" or "*" to match any address.  To match a specific address
use any address or address mask that IPAddr can understand.

Example:

    list = %w[
      deny all
      allow 192.168.1.1
      allow ::ffff:192.168.1.2
      allow 192.168.1.3
    ]

    # From Socket#peeraddr, see also ACL#allow_socket?
    addr = ["AF_INET", 10, "lc630", "192.168.1.3"]

    acl = ACL.new
    p acl.allow_addr?(addr) # => true

    acl = ACL.new(list, ACL::DENY_ALLOW)
    p acl.allow_addr?(addr) # => true

[ACL Reference](https://ruby-doc.org/stdlib-2.6/libdoc/drb/rdoc/ACL.html)