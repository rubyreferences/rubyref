---
title: Concurrency and Parallelism
prev: "/builtin/system-cli/args.html"
next: "/builtin/internals.html"
---

## Thread[](#thread)

Threads are the Ruby implementation for a concurrent programming model.

Programs that require multiple threads of execution are a perfect
candidate for Ruby's Thread class.

For example, we can create a new thread separate from the main thread's
execution using ::new.


```ruby
thr = Thread.new { puts "Whats the big deal" }
```

Then we are able to pause the execution of the main thread and allow our
new thread to finish, using `#join`: 

```ruby
thr.join #=> "Whats the big deal"
```

If we don't call `thr.join` before the main thread terminates, then all
other threads including `thr` will be killed.

Alternatively, you can use an array for handling multiple threads at
once, like in the following example:


```ruby
threads = []
threads << Thread.new { puts "Whats the big deal" }
threads << Thread.new { 3.times { puts "Threads are fun!" } }
```

After creating a few threads we wait for them all to finish
consecutively.


```ruby
threads.each { |thr| thr.join }
```

#### Thread initialization[](#thread-initialization)

In order to create new threads, Ruby provides ::new, ::start, and
::fork. A block must be provided with each of these methods, otherwise a
ThreadError will be raised.

When subclassing the Thread class, the `initialize` method of your
subclass will be ignored by ::start and ::fork. Otherwise, be sure to
call super in your `initialize` method.

#### Thread termination[](#thread-termination)

For terminating threads, Ruby provides a variety of ways to do this.

The class method ::kill, is meant to exit a given thread:


```
thr = Thread.new { ... }
Thread.kill(thr) # sends exit() to thr
```

Alternatively, you can use the instance method `#exit`, or any of its
aliases `#kill` or `#terminate`.


```ruby
thr.exit
```

#### Thread status[](#thread-status)

Ruby provides a few instance methods for querying the state of a given
thread. To get a string with the current thread's state use `#status`


```ruby
thr = Thread.new { sleep }
thr.status # => "sleep"
thr.exit
thr.status # => false
```

You can also use `#alive?` to tell if the thread is running or sleeping,
and `#stop?` if the thread is dead or sleeping.

#### Thread variables and scope[](#thread-variables-and-scope)

Since threads are created with blocks, the same rules apply to other
Ruby blocks for variable scope. Any local variables created within this
block are accessible to only this thread.

##### Fiber-local vs. Thread-local[](#fiber-local-vs-thread-local)

Each fiber has its own bucket for `Thread#[]` storage. When you set a
new fiber-local it is only accessible within this Fiber. To illustrate:


```ruby
Thread.new {
  Thread.current[:foo] = "bar"
  Fiber.new {
    p Thread.current[:foo] # => nil
  }.resume
}.join
```

This example uses `#[]` for getting and `#[]=` for setting fiber-locals,
you can also use `#keys` to list the fiber-locals for a given thread and
`#key?` to check if a fiber-local exists.

When it comes to thread-locals, they are accessible within the entire
scope of the thread. Given the following example:


```ruby
Thread.new{
  Thread.current.thread_variable_set(:foo, 1)
  p Thread.current.thread_variable_get(:foo) # => 1
  Fiber.new{
    Thread.current.thread_variable_set(:foo, 2)
    p Thread.current.thread_variable_get(:foo) # => 2
  }.resume
  p Thread.current.thread_variable_get(:foo)   # => 2
}.join
```

You can see that the thread-local `:foo` carried over into the fiber and
was changed to `2` by the end of the thread.

This example makes use of `#thread_variable_set` to create new
thread-locals, and `#thread_variable_get` to reference them.

There is also `#thread_variables` to list all thread-locals, and
`#thread_variable?` to check if a given thread-local exists.

#### Exception handling[](#exception-handling)

Any thread can raise an exception using the `#raise` instance method,
which operates similarly to `Kernel#raise`.

However, it's important to note that an exception that occurs in any
thread except the main thread depends on `#abort_on_exception`. This
option is `false` by default, meaning that any unhandled exception will
cause the thread to terminate silently when waited on by either `#join`
or `#value`. You can change this default by either
`#abort_on_exception=` `true` or setting $DEBUG to `true`.

With the addition of the class method ::handle\_interrupt, you can now
handle exceptions asynchronously with threads.

#### Scheduling[](#scheduling)

Ruby provides a few ways to support scheduling threads in your program.

The first way is by using the class method ::stop, to put the current
running thread to sleep and schedule the execution of another thread.

Once a thread is asleep, you can use the instance method `#wakeup` to
mark your thread as eligible for scheduling.

You can also try ::pass, which attempts to pass execution to another
thread but is dependent on the OS whether a running thread will switch
or not. The same goes for `#priority`, which lets you hint to the thread
scheduler which threads you want to take precedence when passing
execution. This method is also dependent on the OS and may be ignored on
some platforms.

<a href='https://ruby-doc.org/core-2.5.0/Thread.html' class='ruby-doc
remote' target='_blank'>Thread Reference</a>



### ThreadGroup[](#threadgroup)

ThreadGroup provides a means of keeping track of a number of threads as
a group.

A given Thread object can only belong to one ThreadGroup at a time;
adding a thread to a new group will remove it from any previous group.

Newly created threads belong to the same group as the thread from which
they were created.

<a href='https://ruby-doc.org/core-2.5.0/ThreadGroup.html'
class='ruby-doc remote' target='_blank'>ThreadGroup Reference</a>



### Mutex[](#mutex)

Mutex implements a simple semaphore that can be used to coordinate
access to shared data from multiple concurrent threads.

Example:


```ruby
semaphore = Mutex.new

a = Thread.new {
  semaphore.synchronize {
    # access shared resource
  }
}

b = Thread.new {
  semaphore.synchronize {
    # access shared resource
  }
}
```

<a href='https://ruby-doc.org/core-2.5.0/Mutex.html' class='ruby-doc
remote' target='_blank'>Mutex Reference</a>



### ConditionVariable[](#conditionvariable)

ConditionVariable objects augment class Mutex. Using condition
variables, it is possible to suspend while in the middle of a critical
section until a resource becomes available.

Example:


```ruby
mutex = Mutex.new
resource = ConditionVariable.new

a = Thread.new {
   mutex.synchronize {
     # Thread 'a' now needs the resource
     resource.wait(mutex)
     # 'a' can now have the resource
   }
}

b = Thread.new {
   mutex.synchronize {
     # Thread 'b' has finished using the resource
     resource.signal
   }
}
```

<a href='https://ruby-doc.org/core-2.5.0/ConditionVariable.html'
class='ruby-doc remote' target='_blank'>ConditionVariable Reference</a>



### Queue[](#queue)

The Queue class implements multi-producer, multi-consumer queues. It is
especially useful in threaded programming when information must be
exchanged safely between multiple threads. The Queue class implements
all the required locking semantics.

The class implements FIFO type of queue. In a FIFO queue, the first
tasks added are the first retrieved.

Example:


```ruby
queue = Queue.new

producer = Thread.new do
  5.times do |i|
     sleep rand(i) # simulate expense
     queue << i
     puts "#{i} produced"
  end
end

consumer = Thread.new do
  5.times do |i|
     value = queue.pop
     sleep rand(i/2) # simulate expense
     puts "consumed #{value}"
  end
end
```

<a href='https://ruby-doc.org/core-2.5.0/Queue.html' class='ruby-doc
remote' target='_blank'>Queue Reference</a>



### SizedQueue[](#sizedqueue)

This class represents queues of specified size capacity. The push
operation may be blocked if the capacity is full.

See Queue for an example of how a SizedQueue works.

<a href='https://ruby-doc.org/core-2.5.0/SizedQueue.html'
class='ruby-doc remote' target='_blank'>SizedQueue Reference</a>

