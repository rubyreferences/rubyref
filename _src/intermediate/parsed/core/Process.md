# Process

The module contains several groups of functionality for handling OS processes:

*   Low-level property introspection and management of the current process,
    like Process.argv0, Process.pid;
*   Low-level introspection of other processes, like Process.getpgid,
    Process.getpriority;
*   Management of the current process: Process.abort, Process.exit,
    Process.daemon, etc. (for convenience, most of those are also available as
    global functions and module functions of Kernel);
*   Creation and management of child processes: Process.fork, Process.spawn,
    and related methods;
*   Management of low-level system clock: Process.times and
    Process.clock_gettime, which could be important for proper benchmarking
    and other elapsed time measurement tasks.


[Process Reference](https://ruby-doc.org/core-2.7.0/Process.html)
