---
title: json
prev: "/stdlib/formats/csv.html"
next: "/stdlib/formats/yaml.html"
---


```ruby
require 'json'
```

# JavaScript Object Notation (JSON)

JSON is a lightweight data-interchange format. It is easy for us humans
to read and write. Plus, equally simple for machines to generate or
parse. JSON is completely language agnostic, making it the ideal
interchange format.

Built on two universally available structures: 1. A collection of
name/value pairs. Often referred to as an *object*, hash table, record,
struct, keyed list, or associative array. 2. An ordered list of values.
More commonly called an *array*, vector, sequence or list.

To read more about JSON visit: http://json.org

## Parsing JSON

To parse a JSON string received by another application or generated
within your existing application:


```ruby
require 'json'

my_hash = JSON.parse('{"hello": "goodbye"}')
puts my_hash["hello"] => "goodbye"
```

Notice the extra quotes `''` around the hash notation. Ruby expects the
argument to be a string and can't convert objects like a hash or array.

Ruby converts your string into a hash

## Generating JSON

Creating a JSON string for communication or serialization is just as
simple.


```ruby
require 'json'

my_hash = {:hello => "goodbye"}
puts JSON.generate(my_hash) => "{\"hello\":\"goodbye\"}"
```

Or an alternative way:


```
require 'json'
puts {:hello => "goodbye"}.to_json => "{\"hello\":\"goodbye\"}"
```

`JSON.generate` only allows objects or arrays to be converted to JSON
syntax. `to_json`, however, accepts many Ruby classes even though it
acts only as a method for serialization:


```
require 'json'

1.to_json => "1"
```

<a href='https://ruby-doc.org/stdlib-2.5.0/libdoc/json/rdoc/JSON.html'
class='ruby-doc remote reference' target='_blank'>JSON Reference</a>

