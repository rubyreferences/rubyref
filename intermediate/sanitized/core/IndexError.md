# IndexError

Raised when the given index is invalid.

    a = [:foo, :bar]
    a.fetch(0)   #=> :foo
    a[4]         #=> nil
    a.fetch(4)   #=> IndexError: index 4 outside of array bounds: -2...2