# StandardError

The most standard error types are subclasses of StandardError. A rescue clause
without an explicit Exception class will rescue all StandardErrors (and only
those).

    def foo
      raise "Oups"
    end
    foo rescue "Hello"   #=> "Hello"

On the other hand:

    require 'does/not/exist' rescue "Hi"

*raises the exception:*

    LoadError: no such file to load -- does/not/exist

[StandardError Reference](https://ruby-doc.org/core-2.7.0/StandardError.html)
