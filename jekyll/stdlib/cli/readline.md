---
title: readline
prev: "/stdlib/cli/pty.html"
next: "/stdlib/cli/syslog.html"
---


```ruby
require 'readline'
```

# Readline

The Readline module provides interface for GNU Readline. This module
defines a number of methods to facilitate completion and accesses input
history from the Ruby interpreter. This module supported Edit
Line(libedit) too. libedit is compatible with GNU Readline.

* GNU Readline: http://www.gnu.org/directory/readline.html
* libedit: http://www.thrysoee.dk/editline/

Reads one inputted line with line edit by Readline.readline method. At
this time, the facilitatation completion and the key bind like Emacs can
be operated like GNU Readline.


```ruby
require "readline"
while buf = Readline.readline("> ", true)
  p buf
end
```

The content that the user input can be recorded to the history. The
history can be accessed by Readline::HISTORY constant.


```ruby
require "readline"
while buf = Readline.readline("> ", true)
  p Readline::HISTORY.to_a
  print("-> ", buf, "\n")
end
```

Documented by Kouji Takao <kouji dot="" takao="" at="" gmail=""
com="">.</kouji>

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/readline/rdoc/Readline.html'
class='ruby-doc remote reference' target='_blank'>Readline Reference</a>

