---
title: Range
prev: "/builtin/types/regexp.html"
next: "/builtin/types/struct.html"
---

## Range[](#range)

A Range represents an interval—a set of values with a beginning and an end. Ranges may be constructed using the *s*`..`*e* and *s*`...`*e* literals, or with Range::new. Ranges constructed using `..` run from the beginning to the end inclusively. Those created using `...` exclude the end value. When used as an iterator, ranges return each value in the sequence.


```ruby
(-1..-5).to_a      #=> []
(-5..-1).to_a      #=> [-5, -4, -3, -2, -1]
('a'..'e').to_a    #=> ["a", "b", "c", "d", "e"]
('a'...'e').to_a   #=> ["a", "b", "c", "d"]
```

### Beginless/Endless Ranges[](#beginlessendless-ranges)

<div class="since-version">Since Ruby 2.6 <i>(endless)</i></div>

<div class="since-version">Since Ruby 2.7 <i>(beginless)</i></div>

A "beginless range" and "endless range" represents a semi-infinite range. Literal notation for a beginless range is:


```ruby
(..1)
# or
(...1)
```

Literal notation for an endless range is:


```ruby
(1..)
# or similarly
(1...)
```

Which is equivalent to


```ruby
(1..nil)  # or similarly (1...nil)
Range.new(1, nil) # or Range.new(1, nil, true)
```

Beginless/endless ranges are useful, for example, for idiomatic slicing of arrays:


```ruby
[1, 2, 3, 4, 5][...2]   # => [1, 2]
[1, 2, 3, 4, 5][2...]   # => [3, 4, 5]
```

Some implementation details:

* `begin` of beginless range and `end` of endless range are `nil`;
* `each` of beginless range raises an exception;
* `each` of endless range enumerates infinite sequence (may be useful in combination with Enumerable#take\_while or similar methods);

* `(1..)` and `(1...)` are not equal, although technically representing the same sequence.

### Custom Objects in Ranges[](#custom-objects-in-ranges)

Ranges can be constructed using any objects that can be compared using the `<=>` operator. Methods that treat the range as a sequence (#each and methods inherited from Enumerable) expect the begin object to implement a `succ` method to return the next object in sequence. The `#step` and `#include?` methods require the begin object to implement `succ` or to be numeric.

In the `Xs` class below both `<=>` and `succ` are implemented so `Xs` can be used to construct ranges. Note that the Comparable module is included so the `==` method is defined in terms of `<=>`.


```ruby
class Xs                # represent a string of 'x's
  include Comparable
  attr :length
  def initialize(n)
    @length = n
  end
  def succ
    Xs.new(@length + 1)
  end
  def <=>(other)
    @length <=> other.length
  end
  def to_s
    sprintf "%2d #{inspect}", @length
  end
  def inspect
    'x' * @length
  end
end
```

An example of using `Xs` to construct a range:


```ruby
r = Xs.new(3)..Xs.new(6)   #=> xxx..xxxxxx
r.to_a                     #=> [xxx, xxxx, xxxxx, xxxxxx]
r.member?(Xs.new(5))       #=> true
```

<a href='https://ruby-doc.org/core-2.7.0/Range.html' class='ruby-doc remote' target='_blank'>Range Reference</a>

