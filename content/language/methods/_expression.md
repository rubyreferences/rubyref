## Method definition as an expression

`def` (method definition) is an _expression_ returning the name of the defined method. This
fact is mostly useful for method decoration:

    # Ruby's standard visibility statement
    private def some_private_method
      # ...
    end

    # Decorating with third-party library for memoizing (caching) method value
    memoize def some_expensive_method
      # ...
    end

Both `private` and `memoize` above are just a method calls, receiving result of `def` (method name
to make private/cached) as their argument.