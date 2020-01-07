# KeyError

Raised when the specified key is not found. It is a subclass of IndexError.

    h = {"foo" => :bar}
    h.fetch("foo") #=> :bar
    h.fetch("baz") #=> KeyError: key not found: "baz"

[KeyError Reference](https://ruby-doc.org/core-2.7.0/KeyError.html)