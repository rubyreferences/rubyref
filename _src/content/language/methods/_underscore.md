Repeated argument names is syntax error. There is one exception: the special name `_` to designate
unused argument(s).

    def some_method(x, y, x) # Syntax error
      # ...
    end

    def some_method(_, y, _) # OK
      # ...
    end

This is useful for redefining methods, when client code expects a particular calling convention.
