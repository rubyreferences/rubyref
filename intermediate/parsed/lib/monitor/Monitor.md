# Monitor

Use the Monitor class when you want to have a lock object for blocks with
mutual exclusion.

    require 'monitor'

    lock = Monitor.new
    lock.synchronize do
      # exclusive access
    end
