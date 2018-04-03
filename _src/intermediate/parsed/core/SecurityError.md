# SecurityError

Raised when attempting a potential unsafe operation, typically when the $SAFE
level is raised above 0.

    foo = "bar"
    proc = Proc.new do
      $SAFE = 3
      foo.untaint
    end
    proc.call

*raises the exception:*

    SecurityError: Insecure: Insecure operation `untaint' at level 3

[SecurityError Reference](https://ruby-doc.org/core-2.5.0/SecurityError.html)
