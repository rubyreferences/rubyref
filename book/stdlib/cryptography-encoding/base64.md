# Base64

The Base64 module provides for the encoding (#encode64,
`#strict_encode`64, `#urlsafe_encode`64) and decoding (#decode64,
`#strict_decode`64, `#urlsafe_decode`64) of binary data using a Base64
representation.

## Example

A simple encoding and decoding.


```ruby
require "base64"

enc   = Base64.encode64('Send reinforcements')
                    # -> "U2VuZCByZWluZm9yY2VtZW50cw==\n"
plain = Base64.decode64(enc)
                    # -> "Send reinforcements"
```

The purpose of using base64 to encode data is that it translates any
binary data into purely printable characters.

[Base64
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/base64/rdoc/Base64.html)

