---
title: scanf
prev: "/stdlib/string-utilities/racc.html"
next: "/stdlib/string-utilities/shellwords.html"
---


```ruby
require 'scanf'
```

# scanf



scanf is an implementation of the C function scanf(3), modified as
necessary for Ruby compatibility.

The methods provided are `String#scanf`, `IO#scanf`, and `Kernel#scanf`.
Kernel#scanf is a wrapper around STDIN.scanf. `IO#scanf` can be used on
any IO stream, including file handles and sockets. scanf can be called
either with or without a block.

Scanf scans an input string or stream according to a **format**, as
described below in Conversions, and returns an array of matches between
the format and the input. The format is defined in a string, and is
similar (though not identical) to the formats used in `Kernel#printf`
and `Kernel#sprintf`.

The format may contain **conversion specifiers**, which tell scanf what
form (type) each particular matched substring should be converted to
(e.g., decimal integer, floating point number, literal string, etc.) The
matches and conversions take place from left to right, and the
conversions themselves are returned as an array.

The format string may also contain characters other than those in the
conversion specifiers. Whitespace (blanks, tabs, or newlines) in the
format string matches any amount of whitespace, including none, in the
input. Everything else matches only itself.

Scanning stops, and scanf returns, when any input character fails to
match the specifications in the format string, or when input is
exhausted, or when everything in the format string has been matched. All
matches found up to the stopping point are returned in the return array
(or yielded to the block, if a block was given).



### Basic usage


```ruby
require 'scanf'

# String#scanf and IO#scanf take a single argument, the format string
array = a_string.scanf("%d%s")
array = an_io.scanf("%d%s")

# Kernel#scanf reads from STDIN
array = scanf("%d%s")
```



### Block usage

When called with a block, scanf keeps scanning the input, cycling back
to the beginning of the format string, and yields a new array of
conversions to the block every time the format string is matched
(including partial matches, but not including complete failures). The
actual return value of scanf when called with a block is an array
containing the results of all the executions of the block.


```ruby
str = "123 abc 456 def 789 ghi"
str.scanf("%d%s") { |num,str| [ num * 2, str.upcase ] }
# => [[246, "ABC"], [912, "DEF"], [1578, "GHI"]]
```



[Scanf
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/scanf/rdoc/Scanf.html)

