---
title: yaml
prev: "/stdlib/formats/json.html"
next: "/stdlib/formats/rexml.html"
---


```ruby
require 'yaml'
```

# YAML

YAML Ain't Markup Language

This module provides a Ruby interface for data serialization in YAML
format.

The underlying implementation is the libyaml wrapper Psych.

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

## Security

Do not use YAML to load untrusted data. Doing so is unsafe and could
allow malicious input to execute arbitrary code inside your application.
Please see doc/security.rdoc for more information.

<a href='https://ruby-doc.org/stdlib-2.5.0/libdoc/yaml/rdoc/YAML.html'
class='ruby-doc remote' target='_blank'>YAML Reference</a>



<a href='https://ruby-doc.org/stdlib-2.5.0/libdoc/psych/rdoc/Psych.html'
class='ruby-doc remote' target='_blank'>Psych Reference</a>

