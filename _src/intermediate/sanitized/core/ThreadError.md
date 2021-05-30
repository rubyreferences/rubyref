# ThreadError

Raised when an invalid operation is attempted on a thread.

For example, when no other thread has been started:

    Thread.stop

This will raises the following exception:

    ThreadError: stopping only thread
    note: use sleep to stop forever

[ThreadError Reference](https://ruby-doc.org/core-2.7.0/ThreadError.html)