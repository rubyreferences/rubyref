# Mutex

Mutex implements a simple semaphore that can be used to coordinate access to
shared data from multiple concurrent threads.

Example:

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

[Mutex Reference](https://ruby-doc.org/core-2.7.0/Mutex.html)
