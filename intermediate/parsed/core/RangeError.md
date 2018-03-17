# RangeError

Raised when a given numerical value is out of range.

    [1, 2, 3].drop(1 << 100)

*raises the exception:*

    RangeError: bignum too big to convert into `long'
