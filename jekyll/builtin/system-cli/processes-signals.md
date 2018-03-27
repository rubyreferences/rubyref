# Process

Module to handle processes.

[Process Reference](http://ruby-doc.org/core-2.5.0/Process.html)



## Signal

Many operating systems allow signals to be sent to running processes.
Some signals have a defined effect on the process, while others may be
trapped at the code level and acted upon. For example, your process may
trap the USR1 signal and use it to toggle debugging, and may use TERM to
initiate a controlled shutdown.


```ruby
pid = fork do
  Signal.trap("USR1") do
    $debug = !$debug
    puts "Debug now: #$debug"
  end
  Signal.trap("TERM") do
    puts "Terminating..."
    shutdown()
  end
  # . . . do some work . . .
end

Process.detach(pid)

# Controlling program:
Process.kill("USR1", pid)
# ...
Process.kill("USR1", pid)
# ...
Process.kill("TERM", pid)
```

produces: Debug now: true Debug now: false Terminating...

The list of available signal names and their interpretation is system
dependent. Signal delivery semantics may also vary between systems; in
particular signal delivery may not always be reliable.

[Signal Reference](http://ruby-doc.org/core-2.5.0/Signal.html)

