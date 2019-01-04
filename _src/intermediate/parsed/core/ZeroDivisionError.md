# ZeroDivisionError

Raised when attempting to divide an integer by 0.

    42 / 0   #=> ZeroDivisionError: divided by 0

Note that only division by an exact 0 will raise the exception:

    42 /  0.0   #=> Float::INFINITY
    42 / -0.0   #=> -Float::INFINITY
    0  /  0.0   #=> NaN

[ZeroDivisionError Reference](https://ruby-doc.org/core-2.6/ZeroDivisionError.html)
