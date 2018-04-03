# FrozenError

Raised when there is an attempt to modify a frozen object.

    [1, 2, 3].freeze << 4

*raises the exception:*

    FrozenError: can't modify frozen Array

[FrozenError Reference](http://ruby-doc.org/core-2.5.0/FrozenError.html)
