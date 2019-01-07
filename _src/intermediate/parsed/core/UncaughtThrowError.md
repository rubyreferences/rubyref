# UncaughtThrowError

Raised when `throw` is called with a *tag* which does not have corresponding
`catch` block.

    throw "foo", "bar"

*raises the exception:*

    UncaughtThrowError: uncaught throw "foo"

[UncaughtThrowError Reference](https://ruby-doc.org/core-2.6/UncaughtThrowError.html)
