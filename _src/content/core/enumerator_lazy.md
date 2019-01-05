# Enumerator::Lazy

`Enumerator::Lazy` is a special type of `Enumerator`, with enumerating methods (like `#map`,
`#select`, `#grep` and so on) redefined the way they are not processing values immediately, but
gather a list of operations, which would be performed on subsequent `#force` or `#first`.

This allows idiomatic calculations on long or infinite sequence, as well as chaining of calculations
without constructing intermediate arrays.

`Enumerator::Lazy` can be constructed from any `Enumerable` `#lazy` method.

Example:

    lazy = (1..Float::INFINITY).lazy.select(&:odd?).drop(10).take_while { |i| i < 30 }
    # => #<Enumerator::Lazy: #<Enumerator::Lazy: #<Enumerator::Lazy: #<Enumerator::Lazy: 1..Infinity>:select>:drop(10)>:take_while>

    lazy.force
    #=> [21, 23, 25, 27, 29]

    # or
    lazy.first(2)
    #=> [21, 23]