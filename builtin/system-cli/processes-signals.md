---
title: Processes and Signals
prev: "/builtin/system-cli.html"
next: "/builtin/system-cli/io.html"
---

## Process[](#process)

The module contains several groups of functionality for handling OS
processes:

* Low-level property introspection and management of the current
  process, like Process.argv0, Process.pid;

* Low-level introspection of other processes, like Process.getpgid,
  Process.getpriority;

* Management of the current process: Process.abort, Process.exit,
  Process.daemon, etc. (for convenience, most of those are also
  available as global functions and module functions of Kernel);

* Creation and management of child processes: Process.fork,
  Process.spawn, and related methods;

* Management of low-level system clock: Process.times and
  Process.clock\_gettime, which could be important for proper
  benchmarking and other elapsed time measurement tasks.

<a href='https://ruby-doc.org/core-2.7.0/Process.html' class='ruby-doc
remote' target='_blank'>Process Reference</a>



### Signal[](#signal)

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

<a href='https://ruby-doc.org/core-2.7.0/Signal.html' class='ruby-doc
remote' target='_blank'>Signal Reference</a>

