# ThreadError

Raised when an invalid operation is attempted on a thread.

For example, when no other thread has been started:

    Thread.stop

This will raises the following exception:

    ThreadError: stopping only thread
    note: use sleep to stop forever