# Numeric

Numeric is the class from which all higher-level numeric classes should
inherit.

Numeric allows instantiation of heap-allocated objects. Other core numeric
classes such as Integer are implemented as immediates, which means that each
Integer is a single immutable object which is always passed by value.

    a = 1
    1.object_id == a.object_id   #=> true

There can only ever be one instance of the integer `1`, for example. Ruby
ensures this by preventing instantiation. If duplication is attempted, the
same instance is returned.

    Integer.new(1)                   #=> NoMethodError: undefined method `new' for Integer:Class
    1.dup                            #=> 1
    1.object_id == 1.dup.object_id   #=> true

For this reason, Numeric should be used when defining other numeric classes.

Classes which inherit from Numeric must implement `coerce`, which returns a
two-member Array containing an object that has been coerced into an instance
of the new class and `self` (see #coerce).

Inheriting classes should also implement arithmetic operator methods (`+`,
`-`, `*` and `/`) and the `<=>` operator (see Comparable). These methods may
rely on `coerce` to ensure interoperability with instances of other numeric
classes.

    class Tally < Numeric
      def initialize(string)
        @string = string
      end

      def to_s
        @string
      end

      def to_i
        @string.size
      end

      def coerce(other)
        [self.class.new('|' * other.to_i), self]
      end

      def <=>(other)
        to_i <=> other.to_i
      end

      def +(other)
        self.class.new('|' * (to_i + other.to_i))
      end

      def -(other)
        self.class.new('|' * (to_i - other.to_i))
      end

      def *(other)
        self.class.new('|' * (to_i * other.to_i))
      end

      def /(other)
        self.class.new('|' * (to_i / other.to_i))
      end
    end

    tally = Tally.new('||')
    puts tally * 2            #=> "||||"
    puts tally > 1            #=> true

[Numeric Reference](https://ruby-doc.org/core-2.6/Numeric.html)
