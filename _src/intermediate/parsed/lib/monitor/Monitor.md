# Monitor

Use the Monitor class when you want to have a lock object for blocks with
mutual exclusion.

    require 'monitor'

    lock = Monitor.new
    lock.synchronize do
      # exclusive access
    end

[Monitor Reference](https://ruby-doc.org/stdlib-2.6/libdoc/monitor/rdoc/Monitor.html)
