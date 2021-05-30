Since Ruby 2.7, `case` expressions also provide a more powerful experimental
pattern matching feature via the `in` keyword:

    case {a: 1, b: 2, c: 3}
    in a: Integer => m
      "matched: #{m}"
    else
      "not matched"
    end
    # => "matched: 1"

Pattern matching syntax is described on [its own page](rdoc-ref:syntax/pattern_matching.rdoc).