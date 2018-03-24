# SortedSet

SortedSet implements a Set that guarantees that its elements are yielded in
sorted order (according to the return values of their #<=> methods) when
iterating over them.

All elements that are added to a SortedSet must respond to the <=> method for
comparison.

Also, all elements must be *mutually comparable*: `el1 <=> el2` must not
return `nil` for any elements `el1` and `el2`, else an ArgumentError will be
raised when iterating over the SortedSet.

## Example

    require "set"

    set = SortedSet.new([2, 1, 5, 6, 4, 5, 3, 3, 3])
    ary = []

    set.each do |obj|
      ary << obj
    end

    p ary # => [1, 2, 3, 4, 5, 6]

    set2 = SortedSet.new([1, 2, "3"])
    set2.each { |obj| } # => raises ArgumentError: comparison of Fixnum with String failed

[SortedSet Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/set/rdoc/SortedSet.html)