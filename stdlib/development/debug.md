---
title: debug
prev: "/stdlib/development/coverage.html"
next: "/stdlib/development/fiddle.html"
---

# debug



This library provides debugging functionality to Ruby.

To add a debugger to your code, start by requiring `debug` in your
program:


```ruby
def say(word)
  require 'debug'
  puts word
end
```

This will cause Ruby to interrupt execution and show a prompt when the
`say` method is run.

Once you're inside the prompt, you can start debugging your program.


```
(rdb:1) p word
"hello"
```

### Usage

The following is a list of common functionalities that the debugger
provides.

#### Navigating through your code

In general, a debugger is used to find bugs in your program, which often
means pausing execution and inspecting variables at some point in time.

Let's look at an example:


```ruby
def my_method(foo)
  require 'debug'
  foo = get_foo if foo.nil?
  raise if foo.nil?
end
```

When you run this program, the debugger will kick in just before the
`foo` assignment.


```
(rdb:1) p foo
nil
```

In this example, it'd be interesting to move to the next line and
inspect the value of `foo` again. You can do that by pressing `n`: 

```
(rdb:1) n # goes to next line
(rdb:1) p foo
nil
```

You now know that the original value of `foo` was nil, and that it still
was nil after calling `get_foo`.

Other useful commands for navigating through your code are:

* `c`: Runs the program until it either exists or encounters another
  breakpoint. You usually press `c` when you are finished debugging your
  program and want to resume its execution.

* `s`: Steps into method definition. In the previous example, `s` would
  take you inside the method definition of `get_foo`.

* `r`: Restart the program.
* `q`: Quit the program.

#### Inspecting variables

You can use the debugger to easily inspect both local and global
variables. We've seen how to inspect local variables before:


```
(rdb:1) p my_arg
42
```

You can also pretty print the result of variables or expressions:


```
(rdb:1) pp %w{a very long long array containing many words}
["a",
 "very",
 "long",
 ...
]
```

You can list all local variables with +v l+:


```
(rdb:1) v l
  foo => "hello"
```

Similarly, you can show all global variables with +v g+:


```
(rdb:1) v g
  all global variables
```

Finally, you can omit `p` if you simply want to evaluate a variable or
expression


```
(rdb:1) 5**2
25
```

### Staying out of trouble

Make sure you remove every instance of +require 'debug'+ before shipping
your code. Failing to do so may result in your program hanging
unpredictably.

Debug is not available in safe mode.

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/debug/rdoc/DEBUGGER__.html'
class='ruby-doc remote' target='_blank'>debug Reference</a>



## Alternative debugging/breakpoint solutions

Since Ruby 2.5.0, there is <a
href='https://ruby-doc.org/core-2.5.0/Binding.html#method-i-irb'
class='ruby-doc remote' target='_blank'>Binding#irb</a> method, allowing
to enter [IRB](../../intro/irb.md) session at the point of call.

Third-party libraries:

* <a href='https://github.com/deivid-rodriguez/byebug' class='remote'
  target='_blank'>byebug</a> is currently most used and freature-rich
  Ruby debugger;
* <a href='https://github.com/pry/pry' class='remote'
  target='_blank'>pry</a> interactive console (alternative to IRB) also
  provides \[Binding#pry\] method.

