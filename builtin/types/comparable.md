---
title: Comparable
prev: "/builtin/types/atomic.html"
next: "/builtin/types/numbers.html"
---

## Comparable[](#comparable)

The `Comparable` mixin is used by classes whose objects may be ordered.
The class must define the `<=>` operator, which compares the receiver
against another object, returning -1, 0, or +1 depending on whether the
receiver is less than, equal to, or greater than the other object. If
the other object is not comparable then the `<=>` operator should return
nil. `Comparable` uses `<=>` to implement the conventional comparison
operators (`<`, `<=`, `==`, `>=`, and `>`) and the method `between?`.


```ruby
class SizeMatters
  include Comparable
  attr :str
  def <=>(other)
    str.size <=> other.str.size
  end
  def initialize(str)
    @str = str
  end
  def inspect
    @str
  end
end

s1 = SizeMatters.new("Z")
s2 = SizeMatters.new("YY")
s3 = SizeMatters.new("XXX")
s4 = SizeMatters.new("WWWW")
s5 = SizeMatters.new("VVVVV")

s1 < s2                       #=> true
s4.between?(s1, s3)           #=> false
s4.between?(s3, s5)           #=> true
[ s3, s2, s5, s4, s1 ].sort   #=> [Z, YY, XXX, WWWW, VVVVV]
```

<a href='https://ruby-doc.org/core-2.5.0/Comparable.html'
class='ruby-doc remote' target='_blank'>Comparable Reference</a>

