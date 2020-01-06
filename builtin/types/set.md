---
title: Set
prev: "/builtin/types/hash.html"
next: "/builtin/types/matrix.html"
---

## Set[](#set)

*Part of standard library. You need to `require 'set'` before using.*

Set implements a collection of unordered values with no duplicates. This is a hybrid of Array's intuitive inter-operation facilities and Hash's fast lookup.

Set is easy to use with Enumerable objects (implementing `each`). Most of the initializer methods and binary operators accept generic Enumerable objects besides sets and arrays. An Enumerable object can be converted to Set using the `to_set` method.

Set uses Hash as storage, so you must note the following points:

* Equality of elements is determined according to `Object#eql?` and Object#hash. Use Set#compare\_by\_identity to make a set compare its elements by their identity.

* Set assumes that the identity of each element does not change while it is stored. Modifying an element of a set will render the set to an unreliable state.

* When a string is to be stored, a frozen copy of the string is stored instead unless the original string is already frozen.

### Comparison[](#comparison)

The comparison operators <, >, <=, and >= are implemented as shorthand for the \{proper\_,}\{subset?,superset?} methods. However, the <=> operator is intentionally left out because not every pair of sets is comparable (\{x, y} vs. \{x, z} for example).

### Example[](#example)


```ruby
require 'set'
s1 = Set[1, 2]                        #=> #<Set: {1, 2}>
s2 = [1, 2].to_set                    #=> #<Set: {1, 2}>
s1 == s2                              #=> true
s1.add("foo")                         #=> #<Set: {1, 2, "foo"}>
s1.merge([2, 6])                      #=> #<Set: {1, 2, "foo", 6}>
s1.subset?(s2)                        #=> false
s2.subset?(s1)                        #=> true
```

<a href='https://ruby-doc.org/stdlib-2.7.0/libdoc/set/rdoc/Set.html' class='ruby-doc remote' target='_blank'>Set Reference</a>



### SortedSet[](#sortedset)

SortedSet implements a Set that guarantees that its elements are yielded in sorted order (according to the return values of their #<=> methods) when iterating over them.

All elements that are added to a SortedSet must respond to the <=> method for comparison.

Also, all elements must be *mutually comparable*\: `el1 <=> el2` must not return `nil` for any elements `el1` and `el2`, else an ArgumentError will be raised when iterating over the SortedSet.

#### Example[](#example)


```ruby
require "set"

set = SortedSet.new([2, 1, 5, 6, 4, 5, 3, 3, 3])
ary = []

set.each do |obj|
  ary << obj
end

p ary # => [1, 2, 3, 4, 5, 6]

set2 = SortedSet.new([1, 2, "3"])
set2.each { |obj| } # => raises ArgumentError: comparison of Fixnum with String failed
```

<a href='https://ruby-doc.org/stdlib-2.7.0/libdoc/set/rdoc/SortedSet.html' class='ruby-doc remote' target='_blank'>SortedSet Reference</a>

