Unlike other languages, a Ruby program typically doesn't need a `for` loop, using
[Enumerable](builtin/types/enumerable.md) instead:

    # Not idiomatic
    for i in 0..3
      # ...
    end
    # Idiomatic
    (0..3).each do |i|
      # ...
    end

    # Not idiomatic: selecting items
    odds = []
    for value in [1, 2, 3, 4, 5]
      odds.push(value) if value.odd?
    end
    # Still not idiomatic: just each
    odds = []
    [1, 2, 3, 4, 5].each do |value|
      odds.push(value) if value.odd?
    end
    # Idiomatic: specialized Enumerable method
    odds = [1, 2, 3, 4, 5].select { |value| value.odd? }
    # Simplify with Symbol#to_proc
    odds = [1, 2, 3, 4, 5].select(&:odd?)

Note that in a lot of cases `until` and `while` loops also could be replaced with `Enumerable`
methods like `#take_while`, `#drop_while` and others.
