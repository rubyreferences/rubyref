
```ruby
require 'yaml'
```

# YAML

YAML Ain't Markup Language

This module provides a Ruby interface for data serialization in YAML
format.

The YAML module is an alias of Psych, the YAML engine for Ruby.

## Usage

Working with YAML can be very simple, for example:


```ruby
require 'yaml'
# Parse a YAML string
YAML.load("--- foo") #=> "foo"

# Emit some YAML
YAML.dump("foo")     # => "--- foo\n...\n"
{ :a => 'b'}.to_yaml  # => "---\n:a: b\n"
```

As the implementation is provided by the Psych library, detailed
documentation can be found in that library's docs (also part of standard
library).

## Security

Do not use YAML to load untrusted data. Doing so is unsafe and could
allow malicious input to execute arbitrary code inside your application.
Please see doc/security.rdoc for more information.

[YAML
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/yaml/rdoc/YAML.html)



[Psych
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/psych/rdoc/Psych.html)

