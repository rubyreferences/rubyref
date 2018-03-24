# Method

Method objects are created by `Object#method`, and are associated with a
particular object (not just with a class). They may be used to invoke the
method within the object, and as a block associated with an iterator. They may
also be unbound from one object (creating an `UnboundMethod`) and bound to
another.

    class Thing
      def square(n)
        n*n
      end
    end
    thing = Thing.new
    meth  = thing.method(:square)

    meth.call(9)                 #=> 81
    [ 1, 2, 3 ].collect(&meth)   #=> [1, 4, 9]

[Method Reference](http://ruby-doc.org/core-2.5.0/Method.html)