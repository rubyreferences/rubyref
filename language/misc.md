---
title: Miscellaneous Syntax
prev: "/language/precedence.html"
next: "/language/files.html"
---

## `BEGIN` and `END`[](#begin-and-end)

`BEGIN` defines a block that is run before any other code in the current
file. It is typically used in one-liners with `ruby -e`. Similarly `END`
defines a block that is run after any other code.

`BEGIN` must appear at top-level and `END` will issue a warning when you
use it inside a method.

Here is an example:


```ruby
BEGIN {
  count = 0
}
```

You must use `{` and `}` you may not use `do` and `end`.

Here is an example one-liner that adds numbers from standard input or
any files in the argument list:


```
ruby -ne 'BEGIN { count = 0 }; END { puts count }; count += gets.to_i'
```

