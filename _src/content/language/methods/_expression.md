## Method definition as an expression

`def` (method definition) is an _expression_ returning the name of the defined method. This
feature is mostly useful for method decoration:

    # Ruby's standard visibility statement
    private def some_private_method
      # ...
    end

    # Decorating with third-party library for memoizing (caching) method value
    memoize def some_expensive_method
      # ...
    end

`private` and `memoize` above are just method calls, receiving the result of `def` (method name
to make private/cached) as their argument.
