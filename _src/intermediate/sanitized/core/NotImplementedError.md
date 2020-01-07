# NotImplementedError

Raised when a feature is not implemented on the current platform. For example,
methods depending on the `fsync` or `fork` system calls may raise this
exception if the underlying operating system or Ruby runtime does not support
them.

Note that if `fork` raises a `NotImplementedError`, then `respond_to?(:fork)`
returns `false`.

[NotImplementedError Reference](https://ruby-doc.org/core-2.7.0/NotImplementedError.html)