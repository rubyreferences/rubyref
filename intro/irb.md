---
title: Interactive Console
prev: intro/implementations.html
next: intro/quickstart.html
---

## IRB[](#irb)

IRB stands for "interactive Ruby" and is a tool to interactively execute
Ruby expressions read from the standard input.

The `irb` command from your shell will start the interpreter.

When executing irb, prompts are displayed as follows. Then, enter the
Ruby expression. An input is executed when it is syntactically complete.


```irb
$ irb
irb(main):001:0> 1+2
#=> 3
irb(main):002:0> class Foo
irb(main):003:1>  def foo
irb(main):004:2>    print 1
irb(main):005:2>  end
irb(main):006:1> end
#=> nil
```

The singleline editor module or multiline editor module can be used with
irb. Use of multiline editor is default if it's installed.

#### Session variables[](#session-variables)

There are a few variables in every Irb session that can come in handy:

* `_`: The value command executed, as a local variable
* `__`: The history of evaluated commands. Available only if
  `IRB.conf[:EVAL_HISTORY]` is not `nil` (which is the default). See
  also IRB::Context#eval\_history= and IRB::History.

* `__[line_no]`: Returns the evaluation value at the given line number,
  `line_no`. If `line_no` is a negative, the return value `line_no` many
  lines before the most recent return value.



> Another popular Ruby interactive console is <a
> href='http://pryrepl.org/' class='remote' target='_blank'>pry</a>.

