# Resolv

Resolv is a thread-aware DNS resolver library written in Ruby.  Resolv can
handle multiple DNS requests concurrently without blocking the entire Ruby
interpreter.

See also resolv-replace.rb to replace the libc resolver with Resolv.

Resolv can look up various DNS resources using the DNS module directly.

Examples:

    p Resolv.getaddress "www.ruby-lang.org"
    p Resolv.getname "210.251.121.214"

    Resolv::DNS.open do |dns|
      ress = dns.getresources "www.ruby-lang.org", Resolv::DNS::Resource::IN::A
      p ress.map(&:address)
      ress = dns.getresources "ruby-lang.org", Resolv::DNS::Resource::IN::MX
      p ress.map { |r| [r.exchange.to_s, r.preference] }
    end

## Bugs

*   NIS is not supported.
*   /etc/nsswitch.conf is not supported.