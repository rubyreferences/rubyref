# Enumerator::Lazy

Enumerator::Lazy is a special type of Enumerator, that allows constructing
chains of operations without evaluating them immediately, and evaluating
values on as-needed basis. In order to do so it redefines most of Enumerable
methods so that they just construct another lazy enumerator.

Enumerator::Lazy can be constructed from any Enumerable with the
Enumerable#lazy method.

    lazy = (1..Float::INFINITY).lazy.select(&:odd?).drop(10).take_while { |i| i < 30 }
    # => #<Enumerator::Lazy: #<Enumerator::Lazy: #<Enumerator::Lazy: #<Enumerator::Lazy: 1..Infinity>:select>:drop(10)>:take_while>

The real enumeration is performed when any non-redefined Enumerable method is
called, like Enumerable#first or Enumerable#to_a (the latter is aliased as
#force for more semantic code):

    lazy.first(2)
    #=> [21, 23]

    lazy.force
    #=> [21, 23, 25, 27, 29]

Note that most Enumerable methods that could be called with or without a
block, on Enumerator::Lazy will always require a block:

    [1, 2, 3].map       #=> #<Enumerator: [1, 2, 3]:map>
    [1, 2, 3].lazy.map  # ArgumentError: tried to call lazy map without a block

This class allows idiomatic calculations on long or infinite sequences, as
well as chaining of calculations without constructing intermediate arrays.

Example for working with a slowly calculated sequence:

    require 'open-uri'

    # This will fetch all URLs before selecting
    # necessary data
    URLS.map { |u| JSON.parse(open(u).read) }
      .select { |data| data.key?('stats') }
      .first(5)

    # This will fetch URLs one-by-one, only till
    # there is enough data to satisfy the condition
    URLS.lazy.map { |u| JSON.parse(open(u).read) }
      .select { |data| data.key?('stats') }
      .first(5)

Ending a chain with ".eager" generates a non-lazy enumerator, which is
suitable for returning or passing to another method that expects a normal
enumerator.

    def active_items
      groups
        .lazy
        .flat_map(&:items)
        .reject(&:disabled)
        .eager
    end

    # This works lazily; if a checked item is found, it stops
    # iteration and does not look into remaining groups.
    first_checked = active_items.find(&:checked)

    # This returns an array of items like a normal enumerator does.
    all_checked = active_items.select(&:checked)

[Enumerator::Lazy Reference](https://ruby-doc.org/core-2.7.0/Enumerator/Lazy.html)
