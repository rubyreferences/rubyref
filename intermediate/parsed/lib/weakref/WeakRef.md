# WeakRef

Weak Reference class that allows a referenced object to be garbage-collected.

A WeakRef may be used exactly like the object it references.

Usage:

    foo = Object.new            # create a new object instance
    p foo.to_s                  # original's class
    foo = WeakRef.new(foo)      # reassign foo with WeakRef instance
    p foo.to_s                  # should be same class
    GC.start                    # start the garbage collector
    p foo.to_s                  # should raise exception (recycled)
