# Range

A `Range` represents an interval---a set of values with a beginning and an
end. Ranges may be constructed using the *s*`..`*e* and *s*`...`*e* literals,
or with Range::new. Ranges constructed using `..` run from the beginning to
the end inclusively. Those created using `...` exclude the end value. When
used as an iterator, ranges return each value in the sequence.

    (-1..-5).to_a      #=> []
    (-5..-1).to_a      #=> [-5, -4, -3, -2, -1]
    ('a'..'e').to_a    #=> ["a", "b", "c", "d", "e"]
    ('a'...'e').to_a   #=> ["a", "b", "c", "d"]

## Custom Objects in Ranges

Ranges can be constructed using any objects that can be compared using the
`<=>` operator. Methods that treat the range as a sequence (#each and methods
inherited from Enumerable) expect the begin object to implement a `succ`
method to return the next object in sequence. The `#step` and `#include?` methods
require the begin object to implement `succ` or to be numeric.

In the `Xs` class below both `<=>` and `succ` are implemented so `Xs` can be
used to construct ranges. Note that the Comparable module is included so the
`==` method is defined in terms of `<=>`.

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

An example of using `Xs` to construct a range:

    r = Xs.new(3)..Xs.new(6)   #=> xxx..xxxxxx
    r.to_a                     #=> [xxx, xxxx, xxxxx, xxxxxx]
    r.member?(Xs.new(5))       #=> true