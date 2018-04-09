**`Enumerable` is a very important module.** It is Ruby's way for performing almost any cycle. The module is included in collections, like `Array` and `Hash` (see next chapters), and some other classes (like `Range`).

    numbers = [1, 2, 8, 9, 18, 7]

    nubmers.each { |n| puts n }       # prints each number
    numbers.map { |n| n**2 }          #=> [1, 4, 64, 81, 324, 49]
    numbers.select { |n| n.odd? }     #=> [1, 9, 7]
    numbers.reject { |n| n.odd? }     #=> [2, 8, 18]
    numbers.partition { |n| n.odd? }  #=> [[1, 9, 7], [2, 8, 18]]
    numbers.sort                      #=> [1, 2, 7, 8, 9, 18]
    numbers.take_while { |n| n < 9 }  #=> [1, 2, 8]
    numbers.drop_while { |n| n < 9 }  #=> [9, 18, 7]
    # ...and so on

    # Range is Enumerable, too
    (1..10).select { |n| n.odd? }   #=> [1, 3, 5, 7, 9]

Also, many Ruby classes that are not `Enumerable` by themselves (like `String`) provide methods which return `Enumerator` (see below), which is also `Enumerable`, and can be processed in the same manner:

    "test".each_char                          #=> #<Enumerator: "test":each_char>
    "test".each_char.select { |c| c < 't' }   #=> ["e", "s"]
    "test".each_char.sort                     #=> ["e", "s", "t", "t"]

