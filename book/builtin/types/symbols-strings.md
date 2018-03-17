# Symbol

`Symbol` objects represent names and some strings inside the Ruby
interpreter. They are generated using the `:name` and `:"string"`
literals syntax, and by the various `to_sym` methods. The same `Symbol`
object will be created for a given name or string for the duration of a
program's execution, regardless of the context or meaning of that name.
Thus if `Fred` is a constant in one context, a method in another, and a
class in a third, the `Symbol` `:Fred` will be the same object in all
three contexts.


```ruby
module One
  class Fred
  end
  $f1 = :Fred
end
module Two
  Fred = 1
  $f2 = :Fred
end
def Fred()
end
$f3 = :Fred
$f1.object_id   #=> 2514190
$f2.object_id   #=> 2514190
$f3.object_id   #=> 2514190
```



## String

A `String` object holds and manipulates an arbitrary sequence of bytes,
typically representing characters. String objects may be created using
`String::new` or as literals.

Because of aliasing issues, users of strings should be aware of the
methods that modify the contents of a `String` object. Typically,
methods with names ending in `!'' modify their receiver, while those
without a`!'' return a new `String`. However, there are exceptions, such
as `String#[]=`.

