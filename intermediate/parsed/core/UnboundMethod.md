# UnboundMethod

Ruby supports two forms of objectified methods. Class `Method` is used to
represent methods that are associated with a particular object: these method
objects are bound to that object. Bound method objects for an object can be
created using `Object#method`.

Ruby also supports unbound methods; methods objects that are not associated
with a particular object. These can be created either by calling
`Module#instance_method` or by calling `unbind` on a bound method object. The
result of both of these is an `UnboundMethod` object.

Unbound methods can only be called after they are bound to an object. That
object must be a kind_of? the method's original class.

    class Square
      def area
        @side * @side
      end
      def initialize(side)
        @side = side
      end
    end

    area_un = Square.instance_method(:area)

    s = Square.new(12)
    area = area_un.bind(s)
    area.call   #=> 144

Unbound methods are a reference to the method at the time it was objectified:
subsequent changes to the underlying class will not affect the unbound method.

    class Test
      def test
        :original
      end
    end
    um = Test.instance_method(:test)
    class Test
      def test
        :modified
      end
    end
    t = Test.new
    t.test            #=> :modified
    um.bind(t).call   #=> :original
