---
title: 'pty: Pseudo terminal'
prev: "/stdlib/cli/optparse.html"
next: "/stdlib/cli/readline.html"
---


```ruby
require 'pty'
```

## PTY[](#pty)

Creates and manages pseudo terminals (PTYs). See also http://en.wikipedia.org/wiki/Pseudo_terminal

PTY allows you to allocate new terminals using ::open or ::spawn a new terminal with a specific command.

### Example[](#example)

In this example we will change the buffering type in the `factor` command, assuming that factor uses stdio for stdout buffering.

If IO.pipe is used instead of PTY.open, this code deadlocks because factor's stdout is fully buffered.


```ruby
# start by requiring the standard library PTY
require 'pty'

master, slave = PTY.open
read, write = IO.pipe
pid = spawn("factor", :in=>read, :out=>slave)
read.close     # we dont need the read
slave.close    # or the slave

# pipe "42" to the factor command
write.puts "42"
# output the response from factor
p master.gets #=> "42: 2 3 7\n"

# pipe "144" to factor and print out the response
write.puts "144"
p master.gets #=> "144: 2 2 2 2 3 3\n"
write.close # close the pipe

# The result of read operation when pty slave is closed is platform
# dependent.
ret = begin
        master.gets     # FreeBSD returns nil.
      rescue Errno::EIO # GNU/Linux raises EIO.
        nil
      end
p ret #=> nil
```

<a href='https://ruby-doc.org/stdlib-2.7.0/libdoc/pty/rdoc/PTY.html' class='ruby-doc remote' target='_blank'>PTY Reference</a>



