# ThWait

This class watches for termination of multiple threads.  Basic functionality
(wait until specified threads have terminated) can be accessed through the
class method ThreadsWait::all_waits.  Finer control can be gained using
instance methods.

Example:

    ThreadsWait.all_waits(thr1, thr2, ...) do |t|
      STDERR.puts "Thread #{t} has terminated."
    end

    th = ThreadsWait.new(thread1,...)
    th.next_wait # next one to be done

[ThWait Reference](https://ruby-doc.org/stdlib-2.6/libdoc/thwait/rdoc/ThWait.html)
