---
title: 'strscan: Sequental String Scanner'
prev: "/stdlib/string-utilities/shellwords.html"
next: "/stdlib/networking-web.html"
---


```ruby
require 'strscan'
```

## StringScanner

StringScanner provides for lexical scanning operations on a String. Here
is an example of its usage:


```ruby
s = StringScanner.new('This is an example string')
s.eos?               # -> false

p s.scan(/\w+/)      # -> "This"
p s.scan(/\w+/)      # -> nil
p s.scan(/\s+/)      # -> " "
p s.scan(/\s+/)      # -> nil
p s.scan(/\w+/)      # -> "is"
s.eos?               # -> false

p s.scan(/\s+/)      # -> " "
p s.scan(/\w+/)      # -> "an"
p s.scan(/\s+/)      # -> " "
p s.scan(/\w+/)      # -> "example"
p s.scan(/\s+/)      # -> " "
p s.scan(/\w+/)      # -> "string"
s.eos?               # -> true

p s.scan(/\s+/)      # -> nil
p s.scan(/\w+/)      # -> nil
```

Scanning a string means remembering the position of a *scan pointer*,
which is just an index. The point of scanning is to move forward a bit
at a time, so matches are sought after the scan pointer; usually
immediately after it.

Given the string "test string", here are the pertinent scan pointer
positions:


```
  t e s t   s t r i n g
0 1 2 ...             1
                      0
```

When you `#scan` for a pattern (a regular expression), the match must
occur at the character after the scan pointer. If you use `#scan_until`,
then the match can occur anywhere after the scan pointer. In both cases,
the scan pointer moves *just beyond* the last character of the match,
ready to scan again from the next character onwards. This is
demonstrated by the example above.

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/strscan/rdoc/StringScanner.html'
class='ruby-doc remote' target='_blank'>StringScanner Reference</a>

