# Thread

Threads are the Ruby implementation for a concurrent programming model.

Programs that require multiple threads of execution are a perfect candidate
for Ruby's Thread class.

For example, we can create a new thread separate from the main thread's
execution using ::new.

    thr = Thread.new { puts "What's the big deal" }

Then we are able to pause the execution of the main thread and allow our new
thread to finish, using #join:

    thr.join #=> "What's the big deal"

If we don't call `thr.join` before the main thread terminates, then all other
threads including `thr` will be killed.

Alternatively, you can use an array for handling multiple threads at once,
like in the following example:

    threads = []
    threads << Thread.new { puts "What's the big deal" }
    threads << Thread.new { 3.times { puts "Threads are fun!" } }

After creating a few threads we wait for them all to finish consecutively.

    threads.each { |thr| thr.join }

To retrieve the last value of a thread, use #value

    thr = Thread.new { sleep 1; "Useful value" }
    thr.value #=> "Useful value"

### Thread initialization

In order to create new threads, Ruby provides ::new, ::start, and ::fork. A
block must be provided with each of these methods, otherwise a ThreadError
will be raised.

When subclassing the Thread class, the `initialize` method of your subclass
will be ignored by ::start and ::fork. Otherwise, be sure to call super in
your `initialize` method.

### Thread termination

For terminating threads, Ruby provides a variety of ways to do this.

The class method ::kill, is meant to exit a given thread:

    thr = Thread.new { sleep }
    Thread.kill(thr) # sends exit() to thr

Alternatively, you can use the instance method #exit, or any of its aliases
#kill or #terminate.

    thr.exit

### Thread status

Ruby provides a few instance methods for querying the state of a given thread.
To get a string with the current thread's state use #status

    thr = Thread.new { sleep }
    thr.status # => "sleep"
    thr.exit
    thr.status # => false

You can also use #alive? to tell if the thread is running or sleeping, and
#stop? if the thread is dead or sleeping.

### Thread variables and scope

Since threads are created with blocks, the same rules apply to other Ruby
blocks for variable scope. Any local variables created within this block are
accessible to only this thread.

#### Fiber-local vs. Thread-local

Each fiber has its own bucket for Thread#[] storage. When you set a new
fiber-local it is only accessible within this Fiber. To illustrate:

    Thread.new {
      Thread.current[:foo] = "bar"
      Fiber.new {
        p Thread.current[:foo] # => nil
      }.resume
    }.join

This example uses #[] for getting and #[]= for setting fiber-locals, you can
also use #keys to list the fiber-locals for a given thread and #key? to check
if a fiber-local exists.

When it comes to thread-locals, they are accessible within the entire scope of
the thread. Given the following example:

    Thread.new{
      Thread.current.thread_variable_set(:foo, 1)
      p Thread.current.thread_variable_get(:foo) # => 1
      Fiber.new{
        Thread.current.thread_variable_set(:foo, 2)
        p Thread.current.thread_variable_get(:foo) # => 2
      }.resume
      p Thread.current.thread_variable_get(:foo)   # => 2
    }.join

You can see that the thread-local `:foo` carried over into the fiber and was
changed to `2` by the end of the thread.

This example makes use of #thread_variable_set to create new thread-locals,
and #thread_variable_get to reference them.

There is also #thread_variables to list all thread-locals, and
#thread_variable? to check if a given thread-local exists.

### Exception handling

When an unhandled exception is raised inside a thread, it will terminate. By
default, this exception will not propagate to other threads. The exception is
stored and when another thread calls #value or #join, the exception will be
re-raised in that thread.

    t = Thread.new{ raise 'something went wrong' }
    t.value #=> RuntimeError: something went wrong

An exception can be raised from outside the thread using the Thread#raise
instance method, which takes the same parameters as Kernel#raise.

Setting Thread.abort_on_exception = true, Thread#abort_on_exception = true, or
$DEBUG = true will cause a subsequent unhandled exception raised in a thread
to be automatically re-raised in the main thread.

With the addition of the class method ::handle_interrupt, you can now handle
exceptions asynchronously with threads.

### Scheduling

Ruby provides a few ways to support scheduling threads in your program.

The first way is by using the class method ::stop, to put the current running
thread to sleep and schedule the execution of another thread.

Once a thread is asleep, you can use the instance method #wakeup to mark your
thread as eligible for scheduling.

You can also try ::pass, which attempts to pass execution to another thread
but is dependent on the OS whether a running thread will switch or not. The
same goes for #priority, which lets you hint to the thread scheduler which
threads you want to take precedence when passing execution. This method is
also dependent on the OS and may be ignored on some platforms.

[Thread Reference](https://ruby-doc.org/core-2.7.0/Thread.html)
