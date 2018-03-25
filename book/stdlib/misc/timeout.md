# Timeout

Timeout long-running blocks


```ruby
require 'timeout'
status = Timeout::timeout(5) {
  # Something that should be interrupted if it takes more than 5 seconds...
}
```

Timeout provides a way to auto-terminate a potentially long-running
operation if it hasn't finished in a fixed amount of time.

Previous versions didn't use a module for namespacing, however
`#timeout` is provided for backwards compatibility. You should prefer
Timeout.timeout instead.

[Timeout
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/timeout/rdoc/Timeout.html)

