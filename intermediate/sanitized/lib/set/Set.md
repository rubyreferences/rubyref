# Set

Set implements a collection of unordered values with no duplicates. This is a
hybrid of Array's intuitive inter-operation facilities and Hash's fast lookup.

Set is easy to use with Enumerable objects (implementing `each`). Most of the
initializer methods and binary operators accept generic Enumerable objects
besides sets and arrays.  An Enumerable object can be converted to Set using
the `to_set` method.

Set uses Hash as storage, so you must note the following points:

*   Equality of elements is determined according to `Object#eql?` and
    Object#hash.  Use Set#compare_by_identity to make a set compare its
    elements by their identity.

*   Set assumes that the identity of each element does not change while it is
    stored.  Modifying an element of a set will render the set to an
    unreliable state.

*   When a string is to be stored, a frozen copy of the string is stored
    instead unless the original string is already frozen.


## Comparison

The comparison operators <, >, <=, and >= are implemented as shorthand for the
{proper_,}{subset?,superset?} methods.  However, the <=> operator is
intentionally left out because not every pair of sets is comparable ({x, y}
vs. {x, z} for example).

## Example

    require 'set'
    s1 = Set[1, 2]                        #=> #<Set: {1, 2}>
    s2 = [1, 2].to_set                    #=> #<Set: {1, 2}>
    s1 == s2                              #=> true
    s1.add("foo")                         #=> #<Set: {1, 2, "foo"}>
    s1.merge([2, 6])                      #=> #<Set: {1, 2, "foo", 6}>
    s1.subset?(s2)                        #=> false
    s2.subset?(s1)                        #=> true

## Contact

    - Akinori MUSHA <knu@iDaemons.org> (current maintainer)

[Set Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/set/rdoc/Set.html)