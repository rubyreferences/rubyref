# DEBUGGER__

This library provides debugging functionality to Ruby.

To add a debugger to your code, start by requiring `debug` in your program:

    def say(word)
      require 'debug'
      puts word
    end

This will cause Ruby to interrupt execution and show a prompt when the `say`
method is run.

Once you're inside the prompt, you can start debugging your program.

    (rdb:1) p word
    "hello"

## Getting help

You can get help at any time by pressing `h`.

    (rdb:1) h
    Debugger help v.-0.002b
    Commands
      b[reak] [file:|class:]<line|method>
      b[reak] [class.]<line|method>
                                 set breakpoint to some position
      wat[ch] <expression>       set watchpoint to some expression
      cat[ch] (<exception>|off)  set catchpoint to an exception
      b[reak]                    list breakpoints
      cat[ch]                    show catchpoint
      del[ete][ nnn]             delete some or all breakpoints
      disp[lay] <expression>     add expression into display expression list
      undisp[lay][ nnn]          delete one particular or all display expressions
      c[ont]                     run until program ends or hit breakpoint
      s[tep][ nnn]               step (into methods) one line or till line nnn
      n[ext][ nnn]               go over one line or till line nnn
      w[here]                    display frames
      f[rame]                    alias for where
      l[ist][ (-|nn-mm)]         list program, - lists backwards
                                 nn-mm lists given lines
      up[ nn]                    move to higher frame
      down[ nn]                  move to lower frame
      fin[ish]                   return to outer frame
      tr[ace] (on|off)           set trace mode of current thread
      tr[ace] (on|off) all       set trace mode of all threads
      q[uit]                     exit from debugger
      v[ar] g[lobal]             show global variables
      v[ar] l[ocal]              show local variables
      v[ar] i[nstance] <object>  show instance variables of object
      v[ar] c[onst] <object>     show constants of object
      m[ethod] i[nstance] <obj>  show methods of object
      m[ethod] <class|module>    show instance methods of class or module
      th[read] l[ist]            list all threads
      th[read] c[ur[rent]]       show current thread
      th[read] [sw[itch]] <nnn>  switch thread context to nnn
      th[read] stop <nnn>        stop thread nnn
      th[read] resume <nnn>      resume thread nnn
      p expression               evaluate expression and print its value
      h[elp]                     print this help
      <everything else>          evaluate

## Usage

The following is a list of common functionalities that the debugger provides.

### Navigating through your code

In general, a debugger is used to find bugs in your program, which often means
pausing execution and inspecting variables at some point in time.

Let's look at an example:

    def my_method(foo)
      require 'debug'
      foo = get_foo if foo.nil?
      raise if foo.nil?
    end

When you run this program, the debugger will kick in just before the `foo`
assignment.

    (rdb:1) p foo
    nil

In this example, it'd be interesting to move to the next line and inspect the
value of `foo` again. You can do that by pressing `n`:

    (rdb:1) n # goes to next line
    (rdb:1) p foo
    nil

You now know that the original value of `foo` was nil, and that it still was
nil after calling `get_foo`.

Other useful commands for navigating through your code are:

`c`
:   Runs the program until it either exists or encounters another breakpoint.
    You usually press `c` when you are finished debugging your program and
    want to resume its execution.
`s`
:   Steps into method definition. In the previous example, `s` would take you
    inside the method definition of `get_foo`.
`r`
:   Restart the program.
`q`
:   Quit the program.


### Inspecting variables

You can use the debugger to easily inspect both local and global variables.
We've seen how to inspect local variables before:

    (rdb:1) p my_arg
    42

You can also pretty print the result of variables or expressions:

    (rdb:1) pp %w{a very long long array containing many words}
    ["a",
     "very",
     "long",
     ...
    ]

You can list all local variables with +v l+:

    (rdb:1) v l
      foo => "hello"

Similarly, you can show all global variables with +v g+:

    (rdb:1) v g
      all global variables

Finally, you can omit `p` if you simply want to evaluate a variable or
expression

    (rdb:1) 5**2
    25

### Going beyond basics

Ruby Debug provides more advanced functionalities like switching between
threads, setting breakpoints and watch expressions, and more. The full list of
commands is available at any time by pressing `h`.

## Staying out of trouble

Make sure you remove every instance of +require 'debug'+ before shipping your
code. Failing to do so may result in your program hanging unpredictably.

Debug is not available in safe mode.

[DEBUGGER__ Reference](https://ruby-doc.org/stdlib-2.7.0/libdoc/debug/rdoc/DEBUGGER__.html)
